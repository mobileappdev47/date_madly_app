import 'package:date_madly_app/pages/chat/my_matches.dart';
import 'package:date_madly_app/providers/chat_provider.dart';
import 'package:date_madly_app/utils/body_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// import 'package:timeago/timeago.dart' as timeago;
import '../../common/text_feild_common.dart';
import '../../network/api.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import 'chat_message.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorRes.white,
          leading: Builder(
            builder: (BuildContext context) {
              return Icon(
                Icons.arrow_back_ios_rounded,
                color: ColorRes.appColor,
              );
              Image.asset(
                'assets/icons/drawer.png',
                scale: 3,
              );
            },
          ),
          title: Text(
            'Chat',
            style: appbarTitle(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 25),
                child: CommonTextField(
                  controller: value.searchController,
                  hintText: 'Search Massages',
                  isPrefixIcon: true,
                  prefix: 'assets/icons/Search_Icon.png',
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 30,
              // ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text('New Matches',
                      style: TextStyle(
                          color: ColorRes.darkGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    width: 130,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyMatches(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Show All',
                          style: TextStyle(
                              color: ColorRes.appColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 4,),
                        Icon(
                          Icons.arrow_forward,
                          color: ColorRes.appColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.image.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        radius: 30,
                        child: Image.asset(value.image[index]),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 26),
                    child: Text('Messages',
                        style: TextStyle(
                            color: ColorRes.darkGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
              SizedBox(
                width: 36,
              ),
              SizedBox(
                height: 350,
                child: ListView.builder(
                  itemCount: value.image.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                          padding: EdgeInsets.all(15),
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          color: ColorRes.lgrey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    value.image[index],
                                    scale: 3,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Row(
                                          children: [
                                            Text('Patrcia',
                                                style: TextStyle(
                                                    color: ColorRes.darkGrey,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            SizedBox(
                                              width: 130,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text('08:33 PM',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xffACACAC))),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: SizedBox(
                                          width: 260,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            'Omg, that was so much fun. Let\'s goto there',
                                            style: TextStyle(
                                                color: Color(0xffACACAC)),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                          /* Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Image.asset('assets/icons/Add Image (1).png',scale: 3,),
                          ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text('Patrcia',style: TextStyle(
                                  color: ColorRes.darkGrey, fontSize: 15,fontWeight: FontWeight.w700
                              )),
                              Text('08:33 PM')
                            ],
                          )
                        ],
                      )
                      */ /*    Column(
                            children: [
                              Row(
                                children: [

                                  Text('Patrcia',style: TextStyle(
                                      color: ColorRes.darkGrey, fontSize: 15,fontWeight: FontWeight.w700
                                  )),
                                  Text('08:33 PM')
                                ],
                              ),
                            ],
                          ),*/ /*
                         ,
                        ],
                      ),*/
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    Provider.of<ChatProvider>(context, listen: false).chatRoomModel.chatRoom ==
            null
        ? SchedulerBinding.instance.addPostFrameCallback(
            (_) => Provider.of<ChatProvider>(context, listen: false)
                .getAllChatRoom(true),
          )
        : print("ran mutiple times");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder:
          (BuildContext context, ChatProvider chatProvider, Widget? child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: const Text("Chat"),
            centerTitle: true,
            leading: Container(),
          ),
          body: _buildBody(chatProvider),
        );
      },
    );
  }

  _buildBody(ChatProvider chatProvider) {
    return RefreshIndicator(
        onRefresh: () => chatProvider.getAllChatRoom(true),
        child: BodyBuilder(
            apiRequestStatus: chatProvider.apiRequestStatus,
            child: _buildBodyList(chatProvider),
            reload: () => chatProvider.getAllChatRoom(true)));
  }

  _buildBodyList(ChatProvider chatProvider) {
    var userID = chatProvider.id;
    if (chatProvider.chatRoomModel.chatRoom == null ||
        chatProvider.chatRoomModel.chatRoom!.isEmpty) {
      return SizedBox(child: _buildStatic(chatProvider));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextField(decoration: Constants.deco("Quick Search", "Quick Search")),
          _buildStatic(chatProvider),
          ListView.builder(
              shrinkWrap: true,
              itemCount: chatProvider.chatRoomModel.chatRoom!.isNotEmpty
                  ? chatProvider.chatRoomModel.chatRoom?.length
                  : 0,
              itemBuilder: (context, index) {
                var name1 = chatProvider
                    .chatRoomModel.chatRoom?[index].participants?[0].sId;
                var name2 = chatProvider
                    .chatRoomModel.chatRoom?[index].participants?[1].sId;
                if (userID == name1) {
                  chatProvider.targetName = chatProvider
                      .chatRoomModel.chatRoom?[index].participants?[1].name;
                  chatProvider.targetImage = chatProvider.chatRoomModel
                      .chatRoom?[index].participants?[1].images?[0];
                  chatProvider.targetOnline = chatProvider
                      .chatRoomModel.chatRoom?[index].participants?[1].isOnline;
                  chatProvider.updateAt = chatProvider.chatRoomModel
                      .chatRoom?[index].participants?[1].updatedAt;
                  chatProvider.targetID = chatProvider
                      .chatRoomModel.chatRoom?[index].participants?[1].sId;
                } else if (userID == name2) {
                  chatProvider.targetName = chatProvider
                      .chatRoomModel.chatRoom?[index].participants?[0].name;
                  chatProvider.targetImage = chatProvider.chatRoomModel
                      .chatRoom?[index].participants?[0].images?[0];
                  chatProvider.targetOnline = chatProvider
                      .chatRoomModel.chatRoom?[index].participants?[0].isOnline;
                  chatProvider.updateAt = chatProvider.chatRoomModel
                      .chatRoom?[index].participants?[0].updatedAt;
                  chatProvider.targetID = chatProvider
                      .chatRoomModel.chatRoom?[index].participants?[0].sId;
                }
                // print(targetName);
                // chatProvider.subscribeToChatRoom(
                //     chatProvider.chatRoomModel.chatRoom![index].sId!);
                // var time = timeago.format(
                //     DateTime.parse(
                //         chatProvider.chatRoomModel.chatRoom![index].updatedAt!),
                //     locale: 'en_short');
                var time = DateFormat('jm').format(DateTime.parse(
                        chatProvider.chatRoomModel.chatRoom![index].updatedAt!)
                    .toLocal());
                return ListTile(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => ChatScreen(
                                */
/*targetUserName: chatProvider.targetName,
                                targetImage: chatProvider.targetImage,
                                chatroomID: chatProvider
                                    .chatRoomModel.chatRoom![index].sId!,
                                targetID: chatProvider.targetID,
                                updatedAt: chatProvider.updateAt*/ /*

                            )))
                  },
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(
                        Api.cloudFrontImageURL + chatProvider.targetImage),
                    child: chatProvider.targetOnline == 1
                        ? const Stack(children: [
                            Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.green)))
                          ])
                        : const SizedBox(),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(chatProvider.targetName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(time,
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 12))
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.1,
                          child: Text(
                              chatProvider
                                  .chatRoomModel.chatRoom![index].lastMessage!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: chatProvider.chatRoomModel
                                              .chatRoom![index].messageBy !=
                                          chatProvider.id
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                        ),
                        if (chatProvider
                                .chatRoomModel.chatRoom![index].messageBy !=
                            chatProvider.id)
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  width: 10,
                                  height: 10))
                        // Icon(Icons.d)
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  _buildStatic(ChatProvider chatProvider) {
    if (chatProvider.chatRoomModel.chatRoom?.length == 0) {
      return RefreshIndicator(
        onRefresh: () => chatProvider.getAllChatRoom(true),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/anim/no-message.json', reverse: true),
              Text("No one had messages you yet!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              FilledButton.tonal(
                  onPressed: () => chatProvider.getAllChatRoom(true),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: const Text('REFRESH',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      )))
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        // const SizedBox(height: 10),
        // const Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 14),
        //     child: Text("Blaze",
        //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        // Card(
        //   child: ListTile(
        //     leading: const CircleAvatar(
        //       radius: 25,
        //       backgroundImage: NetworkImage(
        //           'https://www.orissapost.com/wp-content/uploads/2020/06/carryminati-1024x576.jpg'),
        //     ),
        //     title: const Text(
        //         "Become a Select Plus Member and get more matches",
        //         style: TextStyle(fontWeight: FontWeight.bold)),
        //     subtitle: Text(
        //       "Check Now >",
        //       style: TextStyle(
        //           color: Theme.of(context).colorScheme.onPrimaryContainer),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 10),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Messages",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        const SizedBox(height: 5),
        // if (chatProvider.chatRoomModel.chatRoom == null ||
        //     chatProvider.chatRoomModel.chatRoom!.isEmpty)
        //   const Center(child: Text("No Messages Found"))
      ],
    );
  }
}
*/
