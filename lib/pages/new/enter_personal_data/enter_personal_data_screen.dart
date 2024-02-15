import 'package:date_madly_app/common/text_feild_common.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/text_style.dart';

class EnterPersonalDataScreen extends StatefulWidget {
  const EnterPersonalDataScreen({Key? key}) : super(key: key);

  @override
  State<EnterPersonalDataScreen> createState() =>
      _EnterPersonalDataScreenState();
}

class _EnterPersonalDataScreenState extends State<EnterPersonalDataScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController jobController = TextEditingController();
    TextEditingController companyController = TextEditingController();
    TextEditingController collegeController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    bool isMale = true;
    bool isFemale = false;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: mulish14400,
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: nameController,
                  hintText: 'Enter name',
                  suffix: 'assets/icons/Human_Icon.png',
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Birthday',
                  style: mulish14400,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    var picked = await showDatePicker(
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: ColorRes.grey,
                            colorScheme: const ColorScheme.light(
                                primary: ColorRes.darkGrey),
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!,
                        );
                      },
                      context: context,
                      firstDate: DateTime(1970),
                      // the earliest allowable
                      lastDate: DateTime.now(),
                      // the latest allowable
                      currentDate: DateTime.now(),
                      initialDate: DateTime.now(),
                    );
                    birthDateController.text = dateFormat.format(picked!);
                    setState(() {});
                  },
                  child: Container(
                    height: 55,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorRes.grey),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: birthDateController,
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: 'Enter date',
                          border: InputBorder.none,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 13.0),
                            child: Image.asset(
                              'assets/icons/Date_Icon.png',
                              color: ColorRes.grey,
                              scale: 3,
                            ),
                          )),
                      onChanged: ((value) => {print(value)}),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Gender',
                  style: mulish14400,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFemale = false;
                            isMale = true;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(
                                color: isMale == true
                                    ? ColorRes.appColor
                                    : ColorRes.grey,
                                width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.male_sharp,
                                color: isMale == true
                                    ? ColorRes.appColor
                                    : ColorRes.grey,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Male',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isMale == true
                                      ? ColorRes.appColor
                                      : ColorRes.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = false;
                            isFemale = true;
                          });
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(color: ColorRes.grey, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.female,
                                color: ColorRes.grey,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Female',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: ColorRes.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Location',
                  style: mulish14400,
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: locationController,
                  hintText: 'Enter location',
                  suffix: 'assets/icons/Location_Icon.png',
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Job',
                  style: mulish14400,
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: jobController,
                  hintText: 'Enter job',
                  suffix: 'assets/icons/Worrk_Icon.png',
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Company',
                  style: mulish14400,
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: companyController,
                  hintText: 'Enter company',
                  suffix: 'assets/icons/Company_Icon.png',
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'College',
                  style: mulish14400,
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: collegeController,
                  hintText: 'Enter college',
                  suffix: 'assets/icons/Education_Icon.png',
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'About Me',
                  style: mulish14400,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorRes.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "I'm here when you need a sunny day, something good We can sing together on the beach and burn bonfires at night with the moonlight.",
                      style: mulish14400.copyWith(
                          color: ColorRes.darkGrey, fontSize: 14),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      color: ColorRes.appColor,
                    ),
                    child: Text('Continue',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
