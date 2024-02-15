import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'name.dart';

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  var _gender;
  var _selectedGender;
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.only(
            bottom: 8.0, top: 8.0, right: 16.0, left: 16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.center,
                          child: Card(
                              color: Colors.green[900],
                              child: const Padding(
                                  padding: EdgeInsets.only(
                                      top: 6, bottom: 6, left: 25, right: 25),
                                  child: Text("Welcome to DateMadly",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16)))))),
                  Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_obhph3sh.json',
                      reverse: true),
                ],
              ),
              const Text("You are?",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
              const SizedBox(height: 15),
              Wrap(
                  children: List<Widget>.generate(
                Utils.gender.length,
                (int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: ChoiceChip(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      label: Text(Utils.gender[index]),
                      selected: _gender == null ? false : _gender == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _gender = selected ? index : _gender;
                        });
                        _selectedGender = Utils.gender[index];
                        setGenderMoveOn();
                      },
                    ),
                  );
                },
              ).toList()),
              const Spacer(),
              Center(
                  child: ElevatedButton(
                      onPressed: _selectedGender != null
                          ? () => setGenderMoveOn()
                          : null,
                      style: Constants.tonalButton(context),
                      child: Text('Continue'.toUpperCase()))),
              const SizedBox(height: 30)
            ]),
      ),
    );
  }

  setGenderMoveOn() {
    setGender();
    Navigator.push(context, MaterialPageRoute(builder: (c) => const Name()));
  }

  setGender() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("gender", _selectedGender);
  }
}
