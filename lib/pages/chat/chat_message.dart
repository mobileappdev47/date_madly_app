// ignore_for_file: unused_local_variable

import 'package:date_madly_app/network/api.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// import 'package:timeago/timeago.dart' as timeago;
import '../../common/text_feild_common.dart';
import '../../providers/chat_provider.dart';
import '../../utils/body_builder.dart';
import '../../utils/colors.dart';
import 'call.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.lgrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(

            color: Colors.white, // AppBar background color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                // Remove the shadow
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorRes.grey,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Row(
                  children: [
                    Image.asset(
                      'assets/icons/Add Image (1).png',
                      scale: 3,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patricia',
                          style: TextStyle(
                              color: ColorRes.darkGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Online',
                            style: TextStyle(
                                color: ColorRes.darkGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400))
                      ],
                    )
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Image.asset(
                      'assets/icons/Call.png',
                      scale: 3,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Call(),));
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/icons/Video Call.png',
                      scale: 3,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10,)
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 150),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomPaint(
                    painter: ChatBubblePainter(),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: ColorRes.colorFF9BAD,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        'Hi Patricia, You look beautiful.',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0, left: 20),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: SizedBox(
                      child: Text(
                        'Almost all music genres I like, \n but what I like best is rock and roll music.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 50,
                width: 300,
                child: TextField(
                  controller: searchController,
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorRes.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintText: 'Write a message',
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: Image.asset(
                        'assets/icons/Emoticon.png',
                        color: ColorRes.grey,
                        scale: 3,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: Image.asset(
                        'assets/icons/Camera2.png',
                        color: ColorRes.grey,
                        scale: 3,
                      ),
                    ),
                  ),

                  onTap: () {},
                  onChanged: ((value) => {print(value)}),
                ),
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: ColorRes.appColor,
                child: Image.asset(
                  'assets/icons/Send.png',
                  scale: 4,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.colorFF9BAD
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width - 60, size.height - 20);
    path.lineTo(size.width, size.height - 10);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/*
class ChatMessageScreen extends StatefulWidget {
  const ChatMessageScreen(
      {super.key,
      required this.targetUserName,
      required this.targetImage,
      required this.targetID,
      required this.chatroomID,
      required this.updatedAt});

  final String targetUserName;
  final String chatroomID;
  final String targetID;
  final String updatedAt;
  final String targetImage;

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  var chatProvider;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ChatProvider>(context, listen: false)
            .getSingleChat(widget.chatroomID, widget.targetID));

    chatProvider = context.read<ChatProvider>();
    chatProvider.scrollcontroller.addListener(chatProvider.pagination);
    chatProvider.targetIDs = widget.targetID;
    //unsubscribe to chatroom for updates
    // chatProvider.subscribeToChatRoom(widget.targetID);
    super.initState();
  }

  @override
  void dispose() {
    //unsubscribe to chatroom for updates
    // chatProvider.unsubscribeToChatRoom(widget.targetID);
    chatProvider.scrollcontroller.removeListener(chatProvider.pagination);
    chatProvider.targetIDs = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var time =
    //     timeago.format(DateTime.parse(widget.updatedAt), locale: 'en_short');
    // var time = Jiffy.parse(widget.updatedAt).format(pattern: 'hh:mm a');
    var time =
        DateFormat('jm').format(DateTime.parse(widget.updatedAt).toLocal());
    return Consumer<ChatProvider>(
      builder:
          (BuildContext context, ChatProvider chatProvider, Widget? child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: WillPopScope(
            onWillPop: () {
              if (showEmoji) {
                setState(() {
                  showEmoji = !showEmoji;
                });
                return Future.value(false);
              } else {
                if (chatProvider.refresh) chatProvider.getAllChatRoom(true);
                setState(() {});
                return Future.value(true);
              }
            },
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage(Api.cloudFrontImageURL + widget.targetImage)),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.targetUserName),
                        // const SizedBox(height: 5),
                        // Text(
                        //     widget.isOnline == 1
                        //         ? "Online"
                        //         : "last seen at $time",
                        //     style: const TextStyle(
                        //         fontSize: 12, color: Colors.grey))
                      ],
                    )
                  ],
                ),
                // actions: const [
                //   Icon(Icons.call),
                //   SizedBox(width: 5),
                //   Icon(Icons.more_vert),
                //   SizedBox(width: 5),
                // ],
              ),
              body: _buildBody(chatProvider),
            ),
          ),
        );
      },
    );
  }

  _buildBody(ChatProvider chatProvider) {
    return BodyBuilder(
        apiRequestStatus: chatProvider.apiRequestStatus,
        child: _buildBodyList(chatProvider),
        reload: () =>
            chatProvider.getSingleChat(widget.chatroomID, widget.targetID));
  }

  bool showEmoji = false;

  _buildBodyList(ChatProvider chatProvider) {
    var brightness = MediaQuery.of(context).platformBrightness;
    if (chatProvider.chats.chat == null) {
      return const SizedBox();
    }
    bool isDarkMode = brightness == Brightness.dark;

    return SafeArea(
        child: Container(
      child: Column(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
                controller: chatProvider.scrollcontroller,
                reverse: true,
                itemCount: chatProvider.chats.chat?.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var chat = chatProvider.chats.chat?[index];
                  var sameUser = chatProvider.chats.chat?[index].senderID ==
                      chatProvider.id;
                  var senderTime = DateFormat('jm').format(
                      DateTime.parse(chatProvider.chats.chat![index].createdAt!)
                          .toLocal());
                  String newDate;
                  bool isSameDate = false;
                  if (index == 0 && chatProvider.chats.chat!.length == 1) {
                    newDate = chatProvider
                        .groupMessageDateAndTime(chatProvider
                            .chats.chat![index].createdAt
                            .toString())
                        .toString();
                  } else if (index == chatProvider.chats.chat!.length - 1) {
                    newDate = chatProvider
                        .groupMessageDateAndTime(chatProvider
                            .chats.chat![index].createdAt
                            .toString())
                        .toString();
                  } else {
                    final DateTime date = chatProvider.returnDateAndTimeFormat(
                        chatProvider.chats.chat![index].createdAt.toString());
                    final DateTime prevDate =
                        chatProvider.returnDateAndTimeFormat(chatProvider
                            .chats.chat![index + 1].createdAt
                            .toString());
                    isSameDate = date.isAtSameMomentAs(prevDate);
                    newDate = isSameDate
                        ? ''
                        : chatProvider
                            .groupMessageDateAndTime(chatProvider
                                .chats.chat![index].createdAt
                                .toString())
                            .toString();
                  }
                  return Column(
                    children: [
                      if (index == chatProvider.chats.chat!.length - 1 &&
                          chatProvider.showLoadNewChat)
                        const Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: CircularProgressIndicator()),
                      if (index == chatProvider.chats.chat!.length - 1 &&
                          chatProvider.showLoadNewChat == false)
                        const SizedBox(height: 40),
                      if (newDate != "")
                        Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(newDate),
                        )),
                      if (newDate != "") const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: sameUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                // minWidth: 50,
                                maxWidth:
                                    MediaQuery.of(context).size.width / 1.55),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 12),
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                                color: sameUser
                                    ? isDarkMode
                                        ? Colors.blue[700]
                                        : Colors.blue[200]
                                    : isDarkMode
                                        ? Colors.grey[800]
                                        : Colors.grey[400],
                                borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(20),
                                    topRight: const Radius.circular(20),
                                    bottomLeft: sameUser
                                        ? const Radius.circular(20)
                                        : const Radius.circular(0),
                                    bottomRight: sameUser
                                        ? const Radius.circular(0)
                                        : const Radius.circular(20))),
                            child: Stack(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    chatProvider.chats.chat != null
                                        ? chatProvider.chats.chat![index].msg!
                                            .toString()
                                        : "",
                                    maxLines: 100000,
                                    softWrap: false,
                                    style: const TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis),

                                // Text(senderTime.toString(),
                                //     style: const TextStyle(fontSize: 12))
                              ],
                            ),
                          ),

                          // const SizedBox(width: 10)
                        ],
                      ),

                      const SizedBox(height: 2),

                      Row(
                        mainAxisAlignment: sameUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(senderTime.toString(),
                              style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 5),
                          sameUser
                              ? chat!.status == 'SENT'
                                  ? const Icon(Icons.done_sharp, size: 18)
                                  : chat.status == 'DELIVERED'
                                      ? const Icon(Icons.done_all, size: 18)
                                      : chat.status == 'SEEN'
                                          ? const Icon(Icons.done_all,
                                              size: 18, color: Colors.blue)
                                          : const Icon(Icons.send, size: 18)
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Text(Jiffy.parse(chatProvider.chats.chat![index].updatedAt.toString()).fromNow())
                    ],
                  );
                }),
          )),
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Future.delayed(const Duration(milliseconds: 250),
                                () async {
                              setState(() {
                                showEmoji = !showEmoji;
                              });
                            });
                          },
                          icon: const Icon(Icons.emoji_emotions)),
                      Expanded(
                        child: Container(
                            constraints: BoxConstraints(
                                // minWidth: 50,
                                maxHeight:
                                    MediaQuery.of(context).size.width / 2.2),
                            child: TextField(
                                keyboardType: TextInputType.multiline,
                                controller: chatProvider.messageController,
                                maxLines: null,
                                onTap: () {
                                  if (showEmoji) {
                                    setState(() => showEmoji = !showEmoji);
                                  }
                                },
                                decoration: const InputDecoration(
                                    hintText: "Enter Message",
                                    border: InputBorder.none))),
                      ),
                      IconButton(
                          onPressed: () => print("hello"),
                          icon: const Icon(Icons.image)),
                      IconButton(
                          onPressed: () => print("hello"),
                          icon: const Icon(Icons.camera_alt)),
                      const SizedBox(width: 5)
                      // IconButton(
                      //     onPressed: () => chatProvider
                      //         .sendMessageFromChat(widget.chatroomID),
                      //     icon: const Icon(Icons.send, color: Colors.blue))
                    ],
                  ),
                ),
              ),
              MaterialButton(
                // onPressed: () {
                //   print(chatProvider.messageController.text);
                // },
                onPressed: () => chatProvider.sendMessageFromChat(
                    widget.chatroomID, widget.targetID),
                minWidth: 0,
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12, right: 6, left: 12),
                shape: const CircleBorder(),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const Icon(Icons.send, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 5)
            ],
          ),
          if (showEmoji)
            SizedBox(
              height: MediaQuery.of(context).size.height * .35,
              child: EmojiPicker(
                textEditingController: chatProvider.messageController,
                // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                config: Config(
                  bgColor: Theme.of(context).colorScheme.secondaryContainer,
                  enableSkinTones: true,
                  columns: 8,
                  emojiSizeMax: 32 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.30
                          : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                ),
              ),
            ),
        ],
      ),
    ));
  }
}
*/
