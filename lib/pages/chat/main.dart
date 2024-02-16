import 'package:date_madly_app/pages/chat/my_matches.dart';
import 'package:date_madly_app/pages/login/profile_photo/profile_photo_screen.dart';
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
import '../map/map_page_1.dart';
import '../me/personal_info.dart';
import '../new/enter_personal_data/enter_personal_data_screen.dart';
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
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen1(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: ColorRes.appColor,
                ),
              );
            },
          ),
          title: Text(
            'Chat',
            style: appbarTitle(),
          ),
          actions: [
            value.isImage == true
                ? Row(
                    children: [
                      Image.asset(
                        'assets/icons/Archive_Icon.png',
                        scale: 3,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          value.onTapDelete(value.deleteIndex);
                          setState(() {});
                        },
                        child: Image.asset(
                          'assets/icons/Dump_Icon.png',
                          scale: 3,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 25),
                child: NewTextField(
                  controller: value.searchController,
                  hintText: 'Search Massages',
                  prefix: 'assets/icons/Search_Icon.png',
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'New Matches',
                    style: TextStyle(
                        color: ColorRes.darkGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 160,
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
                        SizedBox(
                          width: 4,
                        ),
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
                    onLongPress: () {
                      setState(() {
                        value.isImage = true;
                        value.boolList[index] = true;
                        value.deleteIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                          padding: EdgeInsets.all(15),
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          color: value.boolList[index]
                              ? ColorRes.appColor.withOpacity(0.2)
                              : ColorRes.lgrey,
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
                          )),
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
