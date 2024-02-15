import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import 'dob.dart';

class Name extends StatefulWidget {
  const Name({super.key});

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  String _name = '';
  late SharedPreferences sharedPreferences;

  final _formKey = GlobalKey<FormState>();

  bool showButton = false;

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
                const Icon(Icons.person_pin, size: 80),
                const Padding(
                    padding: EdgeInsets.only(left: 8, top: 8.0),
                    child: Text("What is your Name?",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            letterSpacing: 0.5))),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: Constants.deco("", ""),
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    } else if (value.trim().length < 4) {
                      return 'Name must be minimum 4 characters long';
                    }
                    return null;
                  },
                  onChanged: (String? val) {
                    _name = val!.trim();
                    print(_name);
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
                const Spacer(),
                Center(
                    child: ElevatedButton(
                        onPressed: showButton
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  setNameMoveOn();
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

  setNameMoveOn() {
    setName();
    Navigator.push(context, MaterialPageRoute(builder: (c) => const DOB()));
  }

  setName() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("name", _name);
  }
}
