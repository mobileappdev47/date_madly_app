import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import 'tall.dart';

class DOB extends StatefulWidget {
  const DOB({super.key});

  @override
  State<DOB> createState() => _DOBState();
}

class _DOBState extends State<DOB> {
  
  late SharedPreferences sharedPreferences;
  var dates;
  var date;
  var month;
  var showbutton = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.cake_rounded, size: 80),
                const Padding(
                    padding: EdgeInsets.only(left: 8, top: 8.0),
                    child: Text("When is your Birthday?",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            letterSpacing: 0.5))),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: Constants.deco("", ""),
                  controller: dateInput,
                  readOnly: true,
                  initialValue: null,
                  validator: (value) {
                    if (value == null) {
                      return 'Invalid DOB';
                    }
                    return null;
                  },
                  onChanged: (v) {
                    // setState(() {
                    //   showbutton = false;
                    // });
                  },
                  onTap: () async {
                    dates = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1950),
                        initialDate: DateTime(2003),
                        lastDate: DateTime(2003),
                        helpText: 'Select Date of Birth',
                        // Can be used as title
                        cancelText: 'Not now',
                        confirmText: 'Done');
                    if (dates != null) {
                      // var to1 = DateTimeField.combine(dates, TimeOfDay.now());
                      var to1 = DateFormat.yMMMMd("en_US").format(dates);
                      date = DateFormat("dd").format(dates);
                      // year = DateFormat("yyyy").format(to1);
                      month = DateFormat("MM").format(dates);

                      setState(() {
                        showbutton = true;
                        dateInput.text = to1;
                      });
                    } else {
                      // setState(() {});
                      // return currentValue;
                    }
                  },
                ),
                // DateTimeField(
                //   decoration: Constants.deco("", ""),
                //   initialValue: null,
                //   validator: (value) {
                //     if (value == null) {
                //       return 'Invalid DOB';
                //     }
                //     return null;
                //   },
                //   format: DateFormat.yMMMMd("en_US"),
                //   onChanged: (v) {
                //     if (v == null) {
                //       setState(() {
                //         showbutton = false;
                //       });
                //     }
                //   },
                //   onShowPicker: (context, currentValue) async {
                //     dates = await showDatePicker(
                //         context: context,
                //         firstDate: DateTime(1950),
                //         initialDate: DateTime(2003),
                //         lastDate: DateTime(2003),
                //         helpText: 'Select Date of Birth',
                //         // Can be used as title
                //         cancelText: 'Not now',
                //         confirmText: 'Done');
                //     if (dates != null) {
                //       var to1 = DateTimeField.combine(dates, TimeOfDay.now());
                //       //
                //       date = DateFormat("dd").format(to1);
                //       // year = DateFormat("yyyy").format(to1);
                //       month = DateFormat("MM").format(to1);
                //       setState(() {
                //         showbutton = true;
                //       });
                //       return DateTimeField.combine(dates, TimeOfDay.now());
                //     } else {
                //       // setState(() {});
                //       return currentValue;
                //     }
                //   },
                // ),
                const Spacer(),
                Center(
                    child: ElevatedButton(
                        onPressed: showbutton
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  setDOBMoveOn();
                                }
                              }
                            : null,
                        style: Constants.tonalButton(context),
                        child: Text('Continue'.toUpperCase()))),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }

  setDOBMoveOn() {
    setDOB();
    Navigator.push(context, MaterialPageRoute(builder: (c) => const Tall()));
  }

  setDOB() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("dob", dates.toString());
    sharedPreferences.setString("date", date.toString());
    sharedPreferences.setString("month", month.toString());
  }
}
