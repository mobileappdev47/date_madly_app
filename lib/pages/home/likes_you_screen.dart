import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/providers/home_main_provider.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/texts.dart';

class LikesYouScreen extends StatefulWidget {
  const LikesYouScreen({Key? key}) : super(key: key);

  @override
  State<LikesYouScreen> createState() => _LikesYouScreenState();
}

class _LikesYouScreenState extends State<LikesYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMainProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorRes.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset(
                  AssertRe.drawer,
                  scale: 3,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Text(
            Strings.likeyou,
            style: poppins.copyWith(
              color: ColorRes.appColor,
              fontSize: 18,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                onPressed: () {
                  value.showNotificationContainer(context);
                },
                icon: Image.asset(
                  AssertRe.notification,
                  scale: 2.5,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                AssertRe.likesYou,
                scale: 3,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Text(
                Strings.noone,
                textAlign: TextAlign.center,
                style: mulishbold.copyWith(
                  color: ColorRes.darkGrey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
