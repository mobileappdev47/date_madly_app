import 'package:date_madly_app/api/additinal_details_api.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/login/Login_with_phone.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/api.dart';
import '../../utils/font_family.dart';
import '../../utils/texts.dart';
import '../../utils/utils.dart';

class AdditionalDetails extends StatefulWidget {
  AdditionalDetails({super.key, required this.pageNo, required this.value});

  int pageNo;
  final String value;

  @override
  State<AdditionalDetails> createState() => _AdditionalDetailsState();
}

class _AdditionalDetailsState extends State<AdditionalDetails> {
  Api api = Api();

  // late String selectedItem;
  late SharedPreferences sharedPreferences;
  bool selected = false;
  Color containerColor = Colors.white;

  var load = false;
  bool loading = false;
  int di = -1;
  late String question;
  late List<String> array;
  int? _selectedIndex;
  var selectedSunSign = '';
  var selectedCuisine = '';
  var selectedPastime = '';
  var selectedReligion = '';
  var selectedSmokingStatus = '';
  var selectedDrinkingStatus = '';
  var selectedFirstDate = '';
  var selectedPersonality = '';
  var selectedLookingFor = '';
  var selectedPoliticalViews = '';
  List<String> sunSignData = [];
  List<String> cuisineData = [];
  List<String> pastimeData = [];
  List<String> Religion = [];
  List<String> SmokingStatus = [];
  List<String> DrinkingStatus = [];
  List<String> FirstDate = [];
  List<String> Personality = [];
  List<String> LookingFor = [];
  List<String> PoliticalViews = [];
  var selectedItem;
  AdditinalDetail additinalDetail = AdditinalDetail();

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
                  style: mulish14400.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: ColorRes.darkGrey,
                      fontFamily: Fonts.poppins),
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
                const SizedBox(height: 20),
                Image.asset(
                  AssertRe.logo,
                  scale: 2.5,
                ),
                const SizedBox(height: 10),
                Text(question,
                    style: mulish14400.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      fontFamily: Fonts.poppins,
                      color: ColorRes.darkGrey,
                    )),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      itemCount: array.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            setState(() async{
                              di = index;

                              if (widget.pageNo == 1) {
                                selectedSunSign = array[index];
                                await additionalApiCall(selectedSunSign: selectedSunSign);
                                sunSignData = array;
                              } else if (widget.pageNo == 2) {
                                selectedCuisine = array[index];
                                await additionalApiCall(selectedCuisine: selectedCuisine);
                                cuisineData= array;
                              } else if (widget.pageNo == 3) {
                                selectedPoliticalViews = array[index];
                                await additionalApiCall(selectedPastime: selectedPastime);
                                pastimeData= array;
                              } else if (widget.pageNo == 4) {
                                selectedLookingFor = array[index];
                                await additionalApiCall(selectedReligion: selectedReligion);
                                Religion= array;
                              } else if (widget.pageNo == 5) {
                                selectedPersonality = array[index];
                                await additionalApiCall(selectedSmokingStatus: selectedSmokingStatus);
                                SmokingStatus= array;
                              } else if (widget.pageNo == 6) {
                                selectedFirstDate = array[index];
                                await additionalApiCall(selectedDrinkingStatus: selectedDrinkingStatus);
                                DrinkingStatus= array;
                              } else if (widget.pageNo == 7) {
                                selectedDrinkingStatus = array[index];
                                await additionalApiCall(selectedFirstDate: selectedFirstDate);
                                FirstDate= array;
                              } else if (widget.pageNo == 8) {
                                selectedSmokingStatus = array[index];
                                await additionalApiCall(selectedPersonality: selectedPersonality);
                                Personality= array;
                              } else if (widget.pageNo == 9) {
                                selectedReligion = array[index];
                                await additionalApiCall(selectedLookingFor: selectedLookingFor);
                                LookingFor= array;
                              } else if (widget.pageNo == 10) {
                                selectedPastime = array[index];
                                await additionalApiCall(selectedPoliticalViews: selectedPoliticalViews);
                                PoliticalViews= array;

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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(ColorRes.appColor)),
                          onPressed: () async {
                            if (widget.pageNo == 10) {
                              callApi();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhoneOTP(),
                                  ));
                            } else {
                              widget.pageNo++;
                              setState(() {
                                getVars();
                              });
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
                                Strings.close,
                                style: mulish14400.copyWith(
                                  fontSize: 16,
                                  color: ColorRes.white,
                                  fontFamily: Fonts.poppins,
                                ),
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
      _selectedIndex = Utils.sunSign.indexOf(widget.value);
      selectedSunSign = widget.value;
      callApi();
    } else if (widget.pageNo == 2) {
      question = "What is your favourite cuisine?";
      array = Utils.cusine;
      _selectedIndex = Utils.cusine.indexOf(widget.value);
      selectedCuisine = widget.value;
      callApi();
    } else if (widget.pageNo == 3) {
      question = "What is your favourite pastime?";
      array = Utils.political;
      _selectedIndex = Utils.political.indexOf(widget.value);
      selectedPastime = widget.value;
      callApi();
    } else if (widget.pageNo == 4) {
      question = "What religion do you follow?";
      array = Utils.lookingFor;
      _selectedIndex = Utils.lookingFor.indexOf(widget.value);
      selectedCuisine = widget.value;
      callApi();
    } else if (widget.pageNo == 5) {
      question = "Do you smoke?";
      array = Utils.personality;
      _selectedIndex = Utils.personality.indexOf(widget.value);
      selectedPastime = widget.value;
      callApi();
    } else if (widget.pageNo == 6) {
      question = "Do you drink?";
      array = Utils.firstDate;
      _selectedIndex = Utils.firstDate.indexOf(widget.value);
      selectedCuisine = widget.value;
      callApi();
    } else if (widget.pageNo == 7) {
      question = "What would be your ideal first date?";
      array = Utils.drink;
      _selectedIndex = Utils.drink.indexOf(widget.value);
      selectedPastime = widget.value;
      callApi();
    } else if (widget.pageNo == 8) {
      question = "What kind of personality do you have?";
      array = Utils.smoke;
      _selectedIndex = Utils.smoke.indexOf(widget.value);
      selectedCuisine = widget.value;
      callApi();
    } else if (widget.pageNo == 9) {
      question = "What are you Looking For?";
      array = Utils.religion;
      _selectedIndex = Utils.religion.indexOf(widget.value);
      selectedPastime = widget.value;
      callApi();
    } else if (widget.pageNo == 10) {
      question = "What are your Political Views?";
      array = Utils.favPastime;
      _selectedIndex = Utils.favPastime.indexOf(widget.value);
      selectedCuisine = widget.value;
      callApi();
    }
  }

  void callApi() {
    if (widget.pageNo == 1) {
      additionalApiCall(selectedSunSign: selectedSunSign);
    } else if (widget.pageNo == 2) {
      additionalApiCall(selectedCuisine: selectedCuisine);
    } else if (widget.pageNo == 3) {
      additionalApiCall(selectedPastime: selectedPastime);
    } else if (widget.pageNo == 4) {
      additionalApiCall(selectedReligion: selectedReligion);
    } else if (widget.pageNo == 5) {
      additionalApiCall(selectedSmokingStatus: selectedSmokingStatus);
    } else if (widget.pageNo == 6) {
      additionalApiCall(selectedDrinkingStatus: selectedDrinkingStatus);
    } else if (widget.pageNo == 7) {
      additionalApiCall(selectedFirstDate: selectedFirstDate);
    } else if (widget.pageNo == 8) {
      additionalApiCall(selectedPersonality: selectedPersonality);
    } else if (widget.pageNo == 9) {
      additionalApiCall(selectedLookingFor: selectedLookingFor);
    } else if (widget.pageNo == 10) {
      additionalApiCall(selectedPoliticalViews: selectedPoliticalViews);
    }
  }

  Future<void> additionalApiCall({
    String selectedSunSign = '',
    String selectedCuisine = '',
    String selectedPastime = '',
    String selectedReligion = '',
    String selectedSmokingStatus = '',
    String selectedDrinkingStatus = '',
    String selectedFirstDate = '',
    String selectedPersonality = '',
    String selectedLookingFor = '',
    String selectedPoliticalViews = '',
  }) async {
    try {

      var response = await AdditinalDetail.additinalApi(
        selectedSunSign: selectedSunSign,
        selectedCuisine: selectedCuisine,
        selectedPastime: selectedPastime,
        selectedReligion: selectedReligion,
        selectedSmokingStatus: selectedSmokingStatus,
        selectedDrinkingStatus: selectedDrinkingStatus,
        selectedFirstDate: selectedFirstDate,
        selectedPersonality: selectedPersonality,
        selectedLookingFor: selectedLookingFor,
        selectedPoliticalViews: selectedPoliticalViews,
      );

      if (response != null) {
      } else {
        print('Something went wrong');
      }
    } catch (e) {

      print('Exception: $e');
    }
  }
}
