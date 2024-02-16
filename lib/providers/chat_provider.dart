import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:date_madly_app/models/chat_room_model.dart';
import 'package:date_madly_app/utils/mqtt_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

import '../models/chats.dart';
import '../network/api.dart';
import '../utils/enum/api_request_status.dart';
import '../utils/functions.dart';

class ChatProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  List image = [
    'assets/icons/Add Image (1).png',
    'assets/icons/Add Image_04.png',
    'assets/icons/Add Image_06.png',
    'assets/icons/Add Image (1).png',
    'assets/icons/Add Image_04.png',
    'assets/icons/Add Image_06.png',
  ];

  List boolList = [false, false, false, false, false, false];

  bool isImage = false;

  onTapDelete(int index) {
    isImage = false;

    boolList[index] = false;
    image.removeAt(index);
  }

  int deleteIndex = 0;

  ///---------------old--------------
  ChatProvider() {
    getID();
  }

  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;

  //  final service = IsarService();
  Api api = Api();
  var id;
  late SharedPreferences sharedPreferences;
  ChatRoomModel chatRoomModel = ChatRoomModel();
  ChatsModel chats = ChatsModel();
  late IO.Socket socket;
  final TextEditingController messageController = TextEditingController();
  final player = AudioPlayer();
  final alarmAudioPath = "audio/sent.mp3";
  bool refresh = false;
  var scrollcontroller = ScrollController();
  var page = 1;
  var limit = 20;
  var showLoadNewChat = false;
  var chatroomIDs;
  var targetIDs;
  var targetName;
  var targetImage;
  var targetOnline;
  var updateAt;
  var targetID;

  void sendMessageFromChat(chatroomID, recieverID) {
    String msg = messageController.text.trim();
    if (msg != "") {
      sendMessage(msg, chatroomID, recieverID);
    }
  }

  void pagination() {
    if ((scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent)) {
      print("End reached " + chatroomIDs + limit.toString());

      if (limit == 20) loadNewChat(chatroomIDs);

      // print(chatroomID);
      // setState(() {
      //   isLoading = true;
      //   page += 1;
      //   //add api for load the more data according to new page
      // });
    }
  }

  Future<void> loadNewChat(chatroomID) async {
    showLoadNewChat = true;
    notifyListeners();
    page++;
    var params = {"chatroomID": chatroomID, "page": page};
    var token = await getToken();
    Future.delayed(const Duration(milliseconds: 200), () async {
      try {
        ChatsModel profile = await api.chat(Api.getAllChatURL, params, token);
        // setChat(profile);
        if (profile.chat!.isNotEmpty) {
          chats.chat!.addAll(profile.chat as Iterable<Chat>);
        }
        limit = profile.chat!.length;
        showLoadNewChat = false;
        setApiRequestStatus(APIRequestStatus.loaded);
      } catch (e) {
        checkError(e);
      }
    });
  }

  getAllChatRoom(show) async {
    if (show) setApiRequestStatus(APIRequestStatus.loading);
    var params = await getUserParams();
    var token = await getToken();
    try {
      ChatRoomModel profile =
          await api.chatRoom(Api.getAllChatRoomURL, params, token);
      setProfile(profile);

      if (show) setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      checkError(e);
    }
  }

  getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('jwtToken');
    return token;
  }

  getSingleChat(chatroomID, targetID) async {
    page = 1;
    limit = 20;
    // connectToChat();
    setApiRequestStatus(APIRequestStatus.loading);
    refresh = false;
    chatroomIDs = chatroomID;
    var token = await getToken();
    var params = {"chatroomID": chatroomID, "page": page, "targetID": targetID};
    try {
      ChatsModel profile = await api.chat(Api.getAllChatURL, params, token);
      setChat(profile);

      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      checkError(e);
    }
  }

  void setProfile(value) {
    chatRoomModel = value;
    notifyListeners();
  }

  void setChat(value) {
    chats = value;
    notifyListeners();
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(APIRequestStatus.connectionError);
    } else {
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }

  getUserParams() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('id');
    var params = {"id": id};
    return params;
  }

  getID() async {
    sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('id');
    connectToMQTT();
    // var params = {"id": id};
    return id;
  }

  // connectToChat() {
  // socket = IO.io('http://localhost:4000', <String, dynamic>{
  //   'autoConnect': false,
  //   'transports': ['websocket'],
  //   "auth": {"token": id}
  // });
  // socket.connect();
  // socket.on('sended', (data) => print(data));
  // socket.onDisconnect((_) => print('disconnect'));
  // socket.on('fromServer', (_) => print(_));
  // }

  connectToMQTT() async {
    await mqttFunctions.startMQTT(id);
    mqttFunctions.client.subscribe(id, MqttQos.atLeastOnce);
    listentoUpdate();
  }

  sendMessage(msg, chatroomID, recieverID) async {
    var uuid = const Uuid();
    var message = {
      "senderID": id,
      "recieveID": recieverID,
      "msg": msg,
      "messageID": uuid.v1(),
      "chatroomID": chatroomID,
      "status": "SENDING",
      "createdAt": DateTime.now().toLocal().toString()
    };
    chats.chat!.insert(0, Chat.fromJson(message));
    notifyListeners();
    messageController.text = '';
    if (mqttFunctions.client.connectionStatus!.state !=
        MqttConnectionState.connected) {
      mqttFunctions.client.disconnect();
    }
    var token = await getToken();
    try {
      Chat profile = await api.sendChat(Api.sendSingleChatURL, message, token);
      // setChat(profile);
      if (profile.chatroomID!.isNotEmpty) {
        for (var element in chats.chat!) {
          if (element.messageID == profile.messageID) {
            element.status = 'SENT';
            player.play(AssetSource(alarmAudioPath));
            refresh = true;
            notifyListeners();
            //
            // print("ELement" + element.messageID.toString());
          }
        }
      }
      // setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      checkError(e);
    }

    // var messages = json.encode(message);

    // chats.chat!.insert(0, Chat.fromJson(message));
    // notifyListeners();
    // messageController.text = '';
    // // socket.emit('SendMessage', message);

    // final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    // builder.addString(messages);

    // mqttFunctions.client
    //     .publishMessage("onMessage", MqttQos.atLeastOnce, builder.payload!);

    // mqttFunctions.client
  }

  listentoUpdate() {
    mqttFunctions.client.updates!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) async {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      if (c[0].topic == id) {
        Uint8List decoded = base64.decode(pt);
        // print();
        var newMessage = utf8.decode(decoded);
        print(newMessage);
        var v = Chat.fromJson(jsonDecode(newMessage));
        if (v.data == 'addMessage') {
          // for (var element in chatRoomModel.chatRoom!) {
          // add message to specific chatroom only
          // print(element.sId);
          if (targetIDs == v.senderID && chatroomIDs == v.chatroomID) {
            chats.chat!.insert(0, v);
            notifyListeners();
            // send message to server and other user that message seen
            // send message _id to server to update status and send other user intimation
            var params = {"_id": v.sId, "status": "SEEN"};
            var token = await getToken();
            api.chat(Api.updateMessageStatusURL, params, token);
            // sendToBroker(params, v);
            // setChat(profile);
          } else {
            var params = {"_id": v.sId, "status": "DELIVERED"};
            var token = await getToken();
            api.chat(Api.updateMessageStatusURL, params, token);
            Vibration.vibrate(pattern: [400, 400, 400, 400]);

            getAllChatRoom(false);
            // sendToBroker(params, v);
          }
          // }
        } else if (v.data == 'updateStatus') {
          // if (id == v.senderID && chatroomIDs == v.chatroomID) {
          print("update STatus called");
          chats.chat!.indexWhere((element) {
            if (element.messageID == v.messageID) {
              element.status = v.status;
              print("Added");
              notifyListeners();
              return true;
            }
            return false;
          });
          notifyListeners();
          // }
        } else if (v.data == 'onlineUpdate') {
          if (v.senderID != id) {
            print("Sender is not same");
            chatRoomModel.chatRoom!.indexWhere((element) {
              if (element.chatroomID == v.chatroomID) {
                if (element.participants![0].sId != v.senderID) {
                  element.participants![0].isOnline = 1;
                  notifyListeners();
                  return true;
                } else if (element.participants![1].sId != v.senderID) {
                  element.participants![0].isOnline = 1;
                  notifyListeners();
                  return true;
                }
              }
              return false;
            });
          }
        }

        // for (var element in chats.chat!) {
        //   if (element.messageID == v.messageID) {
        //     element.status = 'DELIVERED';
        //     notifyListeners();

        //     // print("ELement" + element.messageID.toString());
        //   }
        // }
      } else {
        print("topic: ${c[0].topic}");
      }
    });
  }

  void sendToBroker(params, v) {
    List<int> mydataint = utf8.encode(jsonEncode(params));
    var messages = base64.encode(mydataint);
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(messages);
    mqttFunctions.client
        .publishMessage(v.senderID!, MqttQos.atLeastOnce, builder.payload!);
  }

  groupMessageDateAndTime(String time) {
    var dt = DateTime.parse(time.toString()).toLocal();
    // var originalDate = DateFormat('MM/dd/yyyy').format(dt);

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String difference = '';
    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      difference = "Today";
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else {
      difference = DateFormat.yMMMd().format(dt).toString();
    }

    return difference;
  }

  returnDateAndTimeFormat(String time) {
    var dt = DateTime.parse(time).toLocal();
    // var originalDate = DateFormat('MM/dd/yyyy').format(dt);
    return DateTime(dt.year, dt.month, dt.day);
  }

  subscribeToChatRoom(chatroomID) {
    if (mqttFunctions.client.connectionStatus!.state.name ==
        MqttConnectionState.connected.name) {
      mqttFunctions.client.subscribe(chatroomID, MqttQos.atMostOnce);
      notifyOthers("Online", chatroomID);
    }
  }

  notifyOthers(status, chatroomID) {
    var message = {
      "senderID": id,
      "chatroomID": chatroomID,
      "data": "onlineUpdate",
    };
    var messages = json.encode(message);
    List<int> mydataint = utf8.encode(messages);
    var encodeMessage = base64.encode(mydataint);

    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(encodeMessage);

    mqttFunctions.client
        .publishMessage(chatroomID, MqttQos.atLeastOnce, builder.payload!);
  }

  unsubscribeToChatRoom(chatroomID) {
    mqttFunctions.client.unsubscribe(chatroomID);
  }
}
