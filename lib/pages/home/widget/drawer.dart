import 'package:date_madly_app/providers/home_main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';

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
      builder: (context, value, child) =>  Padding(
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
                  'assets/icons/drawer.png',
                  scale: 3,
                ),
                Text(
                  'Filter',
                  style: TextStyle(color: ColorRes.appColor, fontSize: 16),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gender',
                  style: TextStyle(color: ColorRes.darkGrey, fontSize: 16),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        value.male = !value.male;
                      });


                    },
                    child: Container(

                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(  color:value.male == true ? ColorRes.appColor : ColorRes.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/Male.png',
                            scale: 3,
                            color: value.male == true ? ColorRes.appColor : ColorRes.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 35,
                          ),
                          Text(
                            'Male',
                            style: TextStyle(
                                color: value.male == true ? ColorRes.appColor : ColorRes.grey, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        value.female = !value.female;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: value.female == true ? ColorRes.appColor : ColorRes.grey)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/Female.png',
                              scale: 2.5,
                              color: value.female == true ? ColorRes.appColor : ColorRes.grey,
                            ),SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
                                  color: value.female == true ? ColorRes.appColor : ColorRes.grey, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),*/

            SizedBox(
              height: 45,
              child: ListView.builder(

                  scrollDirection: Axis.horizontal,
                  itemCount: gender.length,
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
                                    ?
                                     ColorRes.appColor : ColorRes.grey
                            ),
                            ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              genderIcon[index],
                              scale: 3,
                              color: index == currentindex
                                  ? ColorRes.appColor
                                  : ColorRes.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              gender[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
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
            SizedBox(height: 20,),
            Container(
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: ColorRes.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  SizedBox(width: 20,),
                  Image.asset(
                    'assets/icons/Location_Icon.png',
                    scale: 4,
                    color: ColorRes.appColor,
                  ),SizedBox(
                    width: MediaQuery.of(context).size.width / 30,
                  ),
                  Text(
                    'Jakarta, Indonesia',
                    style: TextStyle(
                        color: ColorRes.grey, fontSize: 16),
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
                  'Distance',
                  style: TextStyle(color: ColorRes.darkGrey, fontSize: 16),
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
                Text('50 KM',style:  TextStyle(
                    fontSize: 12, color: ColorRes.grey
                ),)
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Age',
                  style: TextStyle(color: ColorRes.darkGrey, fontSize: 16),
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
                Text('20-30',style:  TextStyle(
                    fontSize: 12, color: ColorRes.grey
                ),)
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: MediaQuery.of(context).size.height/ 11,
                width: MediaQuery.of(context).size.width/1.5,
                decoration: BoxDecoration(
                    color: ColorRes.appColor
                    ,borderRadius: BorderRadius.circular(8)
                ),
                child: Center(child: Text('Continue',style: TextStyle(
                    fontSize: 16,
                    color: ColorRes.white),)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height/11,
              width: MediaQuery.of(context).size.width/1.5,
              decoration: BoxDecoration(
                  color: ColorRes.white
                  ,borderRadius: BorderRadius.circular(8)
              ),
              child: Center(child: Text('Clear',style: TextStyle(
                  fontSize: 16,
                  color: ColorRes.grey),)),
            )
          ],
        ),
      ),
    );
  }
  List gender = ['Male', 'Female'];
  List genderIcon = ['assets/icons/Male.png', 'assets/icons/Female.png'];
}
