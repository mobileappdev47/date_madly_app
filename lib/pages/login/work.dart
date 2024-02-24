import 'package:date_madly_app/models/profile_model.dart';
import 'package:date_madly_app/models/user_model.dart';
import 'package:date_madly_app/pages/login/upload_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/api.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';

class Work extends StatefulWidget {
  const Work(
      {super.key,
      required this.show,
      required this.company,
      required this.income,
      required this.id});

  final bool show;
  final String company;
  final String income;
  final String id;

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  var _selectedincome;
  String? _companyName = '';
  late SharedPreferences sharedPreferences;
  Api api = Api();

  final _formKey = GlobalKey<FormState>();

  bool showButton = false;
  var _income;

  @override
  void initState() {
    super.initState();
    if (widget.show) {
      setState(() {
        showButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: widget.show ? AppBar() : null,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.work, size: 80),
                const Padding(
                    padding: EdgeInsets.only(left: 8, top: 8.0),
                    child: Text("Where do you Work?",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            letterSpacing: 0.5))),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.show ? widget.company : null,
                  decoration: Constants.deco("Add Company", "Add Company"),
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Company Name is required';
                    } else if (value.trim().length < 4) {
                      return 'Company Name must be 4 characters long';
                    }
                    return null;
                  },
                  onChanged: (String? val) {
                    _companyName = val?.trim();
                    if (_formKey.currentState!.validate()) {
                      _selectedincome != null
                          ? setState(() {
                              showButton = true;
                            })
                          : null;
                    } else {
                      _selectedincome != null
                          ? setState(() {
                              showButton = false;
                            })
                          : null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 8.0),
                  child: Text("Annual Income (in Lakhs)"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                      children: List<Widget>.generate(
                    Utils.income.length,
                    (int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: ChoiceChip(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          label: Text(Utils.income[index]),
                          selected: widget.show && _income == null
                              ? widget.income == Utils.income[index]
                              : _income == null
                                  ? false
                                  : _income == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _income = selected ? index : _income;
                            });
                            _selectedincome = Utils.income[index];
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                showButton = true;
                              });
                            } else {
                              setState(() {
                                showButton = false;
                              });
                            }
                          },
                        ),
                      );
                    },
                  ).toList()),
                ),
                const Spacer(),
                Center(
                    child: ElevatedButton(
                        onPressed: showButton
                            ? () => widget.show ? updateData()
                            : sendData()
                            : null,
                        style: Constants.tonalButton(context),
                        child: Text(widget.show
                            ? 'Update'.toUpperCase()
                            : 'Continue'.toUpperCase()))),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateData() async {
    // print("selected Income " + _selectedincome);
    var params = {
      "company": _companyName != "" ? _companyName : widget.company,
      "income": _selectedincome ?? widget.income,
      "_id": widget.id
    };
    // UserModel profile = await api.user(Api.updateFieldsURL, params, "");

    // if (profile.user?.income == _selectedincome) {
    //   int count = 0;
    //   // ignore: use_build_context_synchronously
    //   Navigator.of(context).popUntil((_) => count++ >= 2);
    // } else {
    //   int count = 0;
    //   print("done");
    //   // ignore: use_build_context_synchronously
    //   Navigator.of(context).popUntil((_) => count++ >= 2);
    // }
  }

  Future<void> sendData() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    sharedPreferences = await SharedPreferences.getInstance();
    var phoneNo = sharedPreferences.getString('phoneNo') ?? 'empty';
    var gender = sharedPreferences.getString('gender');
    var name = sharedPreferences.getString('name');
    var dob = sharedPreferences.getString("dob");
    var height = sharedPreferences.getInt('height');
    var live = sharedPreferences.getString("live");
    var relStatus = sharedPreferences.getString("relationStatus");
    var degree = sharedPreferences.getString("degree");
    var designation = sharedPreferences.getString("designation");
    var date = sharedPreferences.getString("date");
    var month = sharedPreferences.getString("month");
    var email = sharedPreferences.getString("email") ?? 'empty';
    var type;
    if (phoneNo == 'empty') {
      type = 'email';
    } else if (email == 'empty') {
      type = 'phone';
    }

    var params = {
      "phoneNo": phoneNo,
      "gender": gender,
      "name": name,
      "dob": dob,
      "height": height,
      "live": live,
      "relationStatus": relStatus,
      "degree": degree,
      "designation": designation,
      "company": _companyName,
      "income": _selectedincome,
      "date": date,
      "month": month,
      "device_tokens": fcmToken,
      "email": email,
      "type": type
    };
    print(params);
    // UserModel profile = await api.user(Api.registrationURL, params, "");
    // if (profile.user!.name! != 'User Exists') {
    //   sharedPreferences.setBool("profileCompleted", true);
    //   sharedPreferences.setString("id", profile.user!.sId!);
    //   sharedPreferences.setString("gender", gender!);
    //   sharedPreferences.setString("jwtToken", profile.jwtToken!);
    //   print("Token ${profile.jwtToken}");
    //   // ignore: use_build_context_synchronously
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (c) =>
    //               UploadImage(newLogin: true, profileModel: ProfileModel())));
    //   // print(profile.user!);
    // } else {
    //   sharedPreferences.setBool("profileCompleted", true);
    //   sharedPreferences.setString("id", profile.user!.sId!);
    //   sharedPreferences.setString("jwtToken", profile.jwtToken!);
    //   print("Token ${profile.jwtToken}");
    //   // ignore: use_build_context_synchronously
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (c) =>
    //               UploadImage(newLogin: true, profileModel: ProfileModel())));
    //   print("User Exists done");
    // }
  }
}
