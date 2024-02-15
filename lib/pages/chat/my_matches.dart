import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/text_feild_common.dart';
import '../../providers/chat_provider.dart';
import '../../utils/text_style.dart';
import 'chat_message.dart';

class MyMatches extends StatelessWidget {
  const MyMatches({super.key});

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
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: ColorRes.appColor,
                ),
              );
              Image.asset(
                'assets/icons/drawer.png',
                scale: 3,
              );
            },
          ),
          title: Text(
            'Matches',
            style: appbarTitle(),
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Image.asset(
                    'assets/icons/Filter Icon.png',
                    scale: 1.2,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ],
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
              SizedBox(
                height: 550,
                child: ListView.builder(
                  itemCount: value.image.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                        padding: EdgeInsets.all(15),
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        color: ColorRes.white,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          Text('Patrcia',
                                              style: TextStyle(
                                                  color: ColorRes.darkGrey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            width: 130,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: SizedBox(
                                        width: 230,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          'Fashion Designer',
                                          style: TextStyle(
                                            color: Color(0xffACACAC),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      // image: DecorationImage(image: AssetImage("assets/icons/Chat.png"),scale: 2),
                                      color: ColorRes.appColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                        "assets/icons/Chat.png",
                                        color: ColorRes.white,
                                        height: 16,
                                      ),
                                    ),
                                  ),
                                ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
