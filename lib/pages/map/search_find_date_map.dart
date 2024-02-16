import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/map/map_page_1.dart';
import 'package:date_madly_app/pages/map/map_screen_3.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindDateMap extends StatelessWidget {
  const FindDateMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/icons/map_screen_1.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    color: ColorRes.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        Text(
                          'To continue Blind Date asks you',
                          style: mulish14400.copyWith(
                              fontSize: 16.41, color: ColorRes.darkGrey),
                        ),
                        Text(
                          'to activate GPS.',
                          style: mulish14400.copyWith(
                              fontSize: 16.41, color: ColorRes.darkGrey),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              height: MediaQuery.of(context).size.height / 13,
                              width: MediaQuery.of(context).size.width / 2.6,
                              child: CupertinoButton(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorRes.appColor,
                                child: Text(
                                  'Oke',
                                  style: mulish14400.copyWith(
                                    color: ColorRes.white,
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MapScreen1(),
                                      ));
                                },
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 5,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 13,
                                width: MediaQuery.of(context).size.width / 2.6,
                                child: CupertinoButton(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ColorRes.white,
                                  child: Text(
                                    'No',
                                    style: mulish14400.copyWith(
                                      color: ColorRes.lightGrey,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MapScreen3(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
