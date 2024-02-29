import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/text_feild_common.dart';
import '../../common/text_style.dart';
import '../../providers/chat_provider.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';
import 'chat_message.dart';

class MyMatches extends StatelessWidget {
  MyMatches({super.key, required this.chatUsers});
  final List chatUsers;
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          toolbarHeight: 65,
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
            Strings.matches,
            style: mulishbold.copyWith(
              fontSize: 18.75,
              color: ColorRes.appColor,
            ),
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Image.asset(
                    AssertRe.Filter_Icon,
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
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              NewTextField(
                controller: value.searchController,
                hintText: Strings.search_massages,
                prefix: AssertRe.Search_Icon,
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20,
                  );
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: value.image.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        value.image[index],
                        scale: 3,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.patrcia,
                            style: mulishbold.copyWith(
                              fontSize: 15,
                              color: ColorRes.darkGrey,
                            ),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            Strings.fashion_designer,
                            style: mulish14400.copyWith(
                              fontSize: 14,
                              color: ColorRes.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorRes.appColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Image.asset(
                            AssertRe.chat,
                            color: ColorRes.white,
                            height: 14,
                          ),
                        ),
                      ),
                    ],
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
