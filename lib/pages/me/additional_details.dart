import 'package:date_madly_app/api/additinal_details_api.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/login/Login_with_phone.dart';
import 'package:date_madly_app/pages/login/profile_photo/profile_photo_screen.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';

import '../../network/api.dart';
import '../../utils/font_family.dart';
import '../../utils/texts.dart';
import '../../utils/utils.dart';

class AdditionalDetails extends StatefulWidget {
  AdditionalDetails({super.key, required this.pageNo});

  int pageNo;

  @override
  State<AdditionalDetails> createState() => _AdditionalDetailsState();
}

class _AdditionalDetailsState extends State<AdditionalDetails> {
  Api api = Api();

  bool selected = false;
  Color containerColor = Colors.white;

  bool loading = false;
  int di = -1;
  late String question;
  late List<String> array;
  String selectedSunSign = '';
  String selectedCuisine = '';
  String selectedPastime = '';
  String selectedReligion = '';
  String selectedSmokingStatus = '';
  String selectedDrinkingStatus = '';
  String selectedFirstDate = '';
  String selectedPersonality = '';
  String selectedLookingFor = '';
  String selectedPoliticalViews = '';
  String selectedItem = '';

  // AdditinalDetail additinalDetail = AdditinalDetail();
  String userId = PrefService.getString(PrefKeys.userId);

  @override
  void initState() {
    super.initState();
    getVars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 10),
                Text(
                  Strings.additional_details,
                  style: mulishbold.copyWith(
                    fontSize: 14,
                    color: ColorRes.darkGrey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "question ${widget.pageNo} of 10",
                  style: mulish14400.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: ColorRes.darkGrey,
                      fontFamily: Fonts.poppins),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  AssertRe.logo,
                  scale: 2.5,
                ),
                const SizedBox(height: 10),
                Text(question,
                    style: mulishbold.copyWith(
                      fontSize: 15,
                      color: ColorRes.darkGrey,
                    )),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      itemCount: array.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              di = index;
                              print(array[index]);
                              if (widget.pageNo == 1) {
                                selectedSunSign = array[index];
                              } else if (widget.pageNo == 2) {
                                selectedCuisine = array[index];
                              } else if (widget.pageNo == 3) {
                                selectedPastime = array[index];
                              } else if (widget.pageNo == 4) {
                                selectedReligion = array[index];
                              } else if (widget.pageNo == 5) {
                                selectedSmokingStatus = array[index];
                              } else if (widget.pageNo == 6) {
                                selectedDrinkingStatus = array[index];
                              } else if (widget.pageNo == 7) {
                                selectedFirstDate = array[index];
                              } else if (widget.pageNo == 8) {
                                selectedPersonality = array[index];
                              } else if (widget.pageNo == 9) {
                                selectedLookingFor = array[index];
                              } else if (widget.pageNo == 10) {
                                selectedPoliticalViews = array[index];
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 5),
                            child: Container(
                              padding: EdgeInsets.symmetric(),
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 10,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: di == index
                                          ? ColorRes.appColor
                                          : ColorRes.darkGrey),
                                  borderRadius: BorderRadius.circular(5),
                                  color: di == index
                                      ? ColorRes.appColor
                                      : ColorRes.white),
                              child: Center(
                                child: Text(
                                  array[index],
                                  style: mulish14400.copyWith(
                                      fontWeight: di == index
                                          ? FontWeight.w600
                                          : FontWeight.w300,
                                      fontSize: 14,
                                      color: di == index
                                          ? ColorRes.white
                                          : ColorRes.darkGrey,
                                      fontFamily: Fonts.poppins),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorRes.lightPink,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(ColorRes.appColor)),
                          onPressed: () async {
                            if (widget.pageNo == 1) {
                              Navigator.pop(context);
                            } else {
                              widget.pageNo--;
                              getVars();
                              di = -1;
                              setState(() {});
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: ColorRes.white,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Back',
                                style: mulish14400.copyWith(
                                  fontSize: 14,
                                  color: ColorRes.white,
                                  fontFamily: Fonts.poppins,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(ColorRes.appColor)),
                          onPressed: () async {
                            if (di != -1) {
                              if (widget.pageNo == 10) {
                                callApi();
                                setState(() {});
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfilePhotoScreen(),
                                    ));
                              } else {
                                callApi();
                                setState(() {});
                                widget.pageNo++;
                                getVars();
                                di = -1;
                                setState(() {});
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                duration: Duration(milliseconds: 800),
                                content: Text(
                                  'Please select any option!',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                'Next',
                                style: mulish14400.copyWith(
                                  fontSize: 14,
                                  color: ColorRes.white,
                                  fontFamily: Fonts.poppins,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_outlined,
                                color: ColorRes.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  void getVars() {
    if (widget.pageNo == 1) {
      question = "What is your sun sign?";
      array = Utils.sunSign;
    } else if (widget.pageNo == 2) {
      question = "What is your favourite cuisine?";
      array = Utils.cusine;
    } else if (widget.pageNo == 3) {
      question = "What is your favourite pastime?";
      array = Utils.favPastime;
    } else if (widget.pageNo == 4) {
      question = "What religion do you follow?";
      array = Utils.religion;
    } else if (widget.pageNo == 5) {
      question = "Do you smoke?";
      array = Utils.smoke;
    } else if (widget.pageNo == 6) {
      question = "Do you drink?";
      array = Utils.drink;
    } else if (widget.pageNo == 7) {
      question = "What would be your ideal first date?";
      array = Utils.firstDate;
    } else if (widget.pageNo == 8) {
      question = "What kind of personality do you have?";
      array = Utils.personality;
    } else if (widget.pageNo == 9) {
      question = "What are you Looking For?";
      array = Utils.lookingFor;
    } else if (widget.pageNo == 10) {
      question = "What are your Political Views?";
      array = Utils.political;
    }
  }

  Future<void> callApi() async {
    if (widget.pageNo == 1) {
      Map<String, dynamic> body = {'_id': userId, 'sun_sign': selectedSunSign};
      await detailApiCalling(body, false);
    } else if (widget.pageNo == 2) {
      Map<String, dynamic> body = {'_id': userId, 'cuisine': selectedCuisine};
      await detailApiCalling(body, false);
    } else if (widget.pageNo == 3) {
      Map<String, dynamic> body = {
        '_id': userId,
        'fav_pastime': selectedPastime
      };
      await detailApiCalling(body, false);
    } else if (widget.pageNo == 4) {
      Map<String, dynamic> body = {'_id': userId, 'religion': selectedReligion};
      await detailApiCalling(body, false);
    } else if (widget.pageNo == 5) {
      Map<String, dynamic> body = {
        '_id': userId,
        'smoke': selectedSmokingStatus
      };
      await detailApiCalling(body, false);
    } else if (widget.pageNo == 6) {
      Map<String, dynamic> body = {
        '_id': userId,
        'drink': selectedDrinkingStatus
      };
      await detailApiCalling(body, false);
    } else if (widget.pageNo == 7) {
      Map<String, dynamic> body = {
        '_id': userId,
        'first_date': selectedFirstDate
      };
      await detailApiCalling(body, false);
    } else if (widget.pageNo == 8) {
      Map<String, dynamic> body = {
        '_id': userId,
        'personality': selectedPersonality
      };
      await detailApiCalling(body, false);
    } else if (widget.pageNo == 9) {
      Map<String, dynamic> body = {
        '_id': userId,
        'looking_for': selectedLookingFor
      };
      await detailApiCalling(body, false);
    } else if (widget.pageNo == 10) {
      Map<String, dynamic> body = {
        '_id': userId,
        'political_views': selectedPoliticalViews
      };
      await detailApiCalling(body, true);
    }
  }

  Future<void> detailApiCalling(Map<String, dynamic> body, bool isLastQ) async {
    try {
      await AdditinalDetail.additinalApi(body: body, isLastQuestion: isLastQ);
    } catch (e) {}
  }
}
