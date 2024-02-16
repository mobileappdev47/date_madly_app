import 'package:date_madly_app/models/profile_model.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/pages/login/Login_with_phone.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/api.dart';
import '../../utils/utils.dart';

class AdditionalDetails extends StatefulWidget {
  AdditionalDetails({super.key, required this.pageNo, required this.value});

  int pageNo;
  final String value;

  @override
  State<AdditionalDetails> createState() => _AdditionalDetailsState();
}

class _AdditionalDetailsState extends State<AdditionalDetails> {
  var _gender;
  Api api = Api();
  late String selectedItem;
  late SharedPreferences sharedPreferences;
  bool selected = false;
  Color containerColor = Colors.white;

  var array;
  var question;
  var load = false;
  bool loading = false;
  int di = -1;

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
                const Text("Additional Details",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: ColorRes.darkGrey,
                        fontFamily: 'Poppins')),
                const SizedBox(height: 5),
                Text("question ${widget.pageNo} of 10",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: ColorRes.darkGrey,
                        fontFamily: 'Poppins')),
                const SizedBox(height: 20),
                Image.asset(
                  "assets/icons/logo.png",
                  scale: 2.5,
                ),
                const SizedBox(height: 10),
                Text(question,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      fontFamily: 'Poppins',
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
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 5),
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
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      color: di == index
                                          ? ColorRes.white
                                          : ColorRes.darkGrey,
                                      fontFamily: 'Poppins'),
                                ),
                              ),

                              /*ChoiceChip(
                                checkmarkColor: Colors.transparent,
                                //  _gender == true ? false : _gender == index,
                                //  color: MaterialStateProperty.all(ColorRes.appColor),
                                // materialTapTargetSize: MaterialTapTargetSize.padded,
                                // labelPadding:
                                // const EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width / 5,
                                    vertical: 8),
                                backgroundColor: ColorRes.white,
                                label: Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Center(
                                    child: Text(
                                      array[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                          color: ColorRes.darkGrey,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                ),
                                selectedColor: ColorRes.appColor,

                                selected: _gender == null ? false : _gender == index,
                                onSelected: (bool selected) {
                                  setState(() {
                                    _gender = selected ? index : _gender;
                                  });
                                  print(_gender);
                                  selectedItem = array[index];
                                  update();
                                  // setGenderMoveOn();
                                },
                              ),*/
                            ),
                          ),
                        );
                        // return Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 15, vertical: 2),
                        //   child: Card(
                        //     color: Utils.sunSign[index] == widget.value
                        //         ? Colors.black26
                        //         : null,
                        //     child: Center(
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(15),
                        //         child: Text(Utils.sunSign[index]),
                        //       ),
                        //     ),
                        //   ),
                        // );
                      }),
                ),
                SizedBox(
                  height: 100,
                  child: Card(
                    color: ColorRes.lightPink,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(ColorRes.appColor)),
                          onPressed: () {
                            if (widget.pageNo == 10) {
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
                              Text("Close",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: ColorRes.white,
                                      fontFamily: 'Poppins'))
                            ],
                          ),
                        ),
                        // FilledButton.tonalIcon(
                        //     onPressed: () {},
                        //     icon: const Icon(Icons.arrow_forward),
                        //     label: const Text("Next"))
                      ],
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  update() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("id");
    String item = "";

    if (widget.pageNo == 1) item = "sun_sign";
    if (widget.pageNo == 2) item = "cuisine";
    if (widget.pageNo == 3) item = "political_views";
    if (widget.pageNo == 4) item = "looking_for";
    if (widget.pageNo == 5) item = "personality";
    if (widget.pageNo == 6) item = "first_date";
    if (widget.pageNo == 7) item = "drink";
    if (widget.pageNo == 8) item = "smoke";
    if (widget.pageNo == 9) item = "religion";
    if (widget.pageNo == 10) item = "fav_pastime";
    var params = {item: selectedItem, "_id": id};
    var token = await getToken();
    BasicInfo profile =
        await api.getBasicInfo(Api.updateAdditionalURL, params, token);
    if (profile.userID == id) {
      // ignore: use_build_context_synchronously
      if (widget.pageNo < 10) {
        setState(() {
          widget.pageNo++;
          load = true;
          getVars();
        });
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context, "done");
      }
    }
  }

  getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('jwtToken');
    return token;
  }

  getVars() {
    if (widget.pageNo == 1) {
      question = "What is your sun sign?";
      array = Utils.sunSign;
      _gender = Utils.sunSign.indexOf(widget.value);
    }
    if (widget.pageNo == 2) {
      question = "What is your favourite cuisine?";
      array = Utils.cusine;
      _gender = Utils.cusine.indexOf(widget.value);
    }
    if (widget.pageNo == 3) {
      question = "What is your favourite pastime?";
      array = Utils.favPastime;
      _gender = Utils.favPastime.indexOf(widget.value);
    }
    if (widget.pageNo == 4) {
      question = "What religion do you follow?";
      array = Utils.religion;
      _gender = Utils.religion.indexOf(widget.value);
    }
    if (widget.pageNo == 5) {
      question = "Do you smoke?";
      array = Utils.smoke;
      _gender = Utils.smoke.indexOf(widget.value);
    }
    if (widget.pageNo == 6) {
      question = "Do you drink?";
      array = Utils.drink;
      _gender = Utils.drink.indexOf(widget.value);
    }
    if (widget.pageNo == 7) {
      question = "What would be your ideal first date?";
      array = Utils.firstDate;
      _gender = Utils.firstDate.indexOf(widget.value);
    }
    if (widget.pageNo == 8) {
      question = "What kind of personality do you have?";
      array = Utils.personality;
      _gender = Utils.personality.indexOf(widget.value);
    }
    if (widget.pageNo == 9) {
      question = "What are you Looking For?";
      array = Utils.lookingFor;
      _gender = Utils.lookingFor.indexOf(widget.value);
    }
    if (widget.pageNo == 10) {
      question = "What are your Political Views?";
      array = Utils.political;
      _gender = Utils.political.indexOf(widget.value);
    }
  }
}
