import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/providers/home_main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../../../utils/assert_re.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_family.dart';
import '../../../utils/texts.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  double _currentSliderValue = 0;
  double ageValue = 0;
  var currentindex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMainProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AssertRe.drawer,
                  scale: 3,
                ),
                Text(
                  Strings.filter,
                  style: mulish14400.copyWith(
                      color: ColorRes.appColor,
                      fontSize: 16,
                      fontFamily: Fonts.mulishBold),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.gender,
                  style: mulish14400.copyWith(
                      color: ColorRes.darkGrey,
                      fontSize: 16,
                      fontFamily: Fonts.mulishBold),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            SizedBox(
              height: 45,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Strings.genders.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            currentindex = index;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: index == currentindex
                                      ? ColorRes.appColor
                                      : ColorRes.grey),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AssertRe.genderIcon[index],
                                  scale: 3,
                                  color: index == currentindex
                                      ? ColorRes.appColor
                                      : ColorRes.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  Strings.genders[index],
                                  style: mulish14400.copyWith(
                                    fontFamily: Fonts.mulishBold,
                                    fontSize: 12.4,
                                    color: index == currentindex
                                        ? ColorRes.appColor
                                        : ColorRes.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: ColorRes.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    AssertRe.Location_Icon,
                    scale: 4,
                    color: ColorRes.appColor,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 30,
                  ),
                  Text(
                    Strings.Jakarta,
                    style: mulish14400.copyWith(
                      color: ColorRes.grey,
                      fontSize: 14.06,
                      fontFamily: Fonts.mulishRegular,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.distance,
                  style: mulish14400.copyWith(
                      color: ColorRes.darkGrey,
                      fontSize: 16.41,
                      fontFamily: Fonts.mulishBold),
                )),
            Row(
              children: [
                Container(
                  width: 220,
                  child: Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 150,
                    //  divisions: 10,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ),
                //SizedBox(width: 25,),
                Text(
                  Strings.distancerange,
                  style: mulish14400.copyWith(color: ColorRes.grey),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.age,
                  style: mulish14400.copyWith(
                      color: ColorRes.darkGrey,
                      fontSize: 16.41,
                      fontFamily: Fonts.mulishBold),
                )),
            Row(
              children: [
                Container(
                  width: 220,
                  child: Slider(
                    value: ageValue,
                    min: 0,
                    max: 150,
                    //  divisions: 10,
                    label: ageValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        ageValue = value;
                      });
                    },
                  ),
                ),
                //SizedBox(width: 25,),
                Text(
                  Strings.agerange,
                  style: mulish14400.copyWith(color: ColorRes.grey),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 11,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    color: ColorRes.appColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(
                  Strings.COntinue,
                  style: poppins.copyWith(fontSize: 16, color: Colors.white),
                )),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 11,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                Strings.clear,
                style: poppins.copyWith(fontSize: 16),
              )),
            )
          ],
        ),
      ),
    );
  }
}
