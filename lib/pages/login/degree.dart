import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../../network/api.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'designation.dart';

class Degree extends StatefulWidget {
  const Degree({super.key, required this.show, required this.id});
  final bool show;
  final String id;

  @override
  State<Degree> createState() => _DegreeState();
}

class _DegreeState extends State<Degree> {
  var _selectedDegree;
  var _selectedSubDegree;
  var _degree;
  var hideDegree = false;
  var _subDegree;
  late SharedPreferences sharedPreferences;
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.show ? AppBar() : null,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.school, size: 80),
                const Padding(
                    padding: EdgeInsets.only(left: 8, top: 8.0),
                    child: Text("What is your highest degree?",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            letterSpacing: 0.5))),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        hideDegree = false;
                      }),
                      child: Text(_selectedDegree ?? "",
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              letterSpacing: 1)),
                    ),
                    Text(_selectedDegree == null ? "" : " in ",
                        style: const TextStyle(fontSize: 20)),
                    Text(_selectedSubDegree ?? "",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            letterSpacing: 1)),
                  ],
                ),
                const SizedBox(height: 25),
                const Center(child: Text("Select a Degree")),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: !hideDegree
                      ? Wrap(
                          children: List<Widget>.generate(
                          Utils.degree.length,
                          (int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: ChoiceChip(
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                label: Text(Utils.degree[index]),
                                selected:
                                    _degree == null ? false : _degree == index,
                                onSelected: (bool selected) {
                                  setState(() {
                                    _degree = selected ? index : _degree;
                                    hideDegree = true;
                                    _selectedSubDegree = "";
                                    _subDegree = null;
                                  });
                                  _selectedDegree = Utils.degree[index];
                                },
                              ),
                            );
                          },
                        ).toList())
                      : Wrap(
                          children: List<Widget>.generate(
                          _selectedDegree == "High School"
                              ? Utils.highSchool.length
                              : _selectedDegree == 'Bachelors' ||
                                      _selectedDegree == 'Masters'
                                  ? Utils.bachelorsMasters.length
                                  : _selectedDegree == 'PhD'
                                      ? Utils.phd.length
                                      : Utils.others.length,
                          (int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: ChoiceChip(
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                label: _selectedDegree == "High School"
                                    ? Text(Utils.highSchool[index])
                                    : _selectedDegree == 'Bachelors' ||
                                            _selectedDegree == 'Masters'
                                        ? Text(Utils.bachelorsMasters[index])
                                        : _selectedDegree == 'PhD'
                                            ? Text(Utils.phd[index])
                                            : Text(Utils.others[index]),
                                selected: _subDegree == null
                                    ? false
                                    : _subDegree == index,
                                onSelected: (bool selected) {
                                  setState(() {
                                    _subDegree = selected ? index : _subDegree;
                                    hideDegree = true;
                                  });
                                  _selectedSubDegree =
                                      _selectedDegree == "High School"
                                          ? Utils.highSchool[index]
                                          : _selectedDegree == 'Bachelors' ||
                                                  _selectedDegree == 'Masters'
                                              ? Utils.bachelorsMasters[index]
                                              : _selectedDegree == 'PhD'
                                                  ? Utils.phd[index]
                                                  : Utils.others[index];

                                  widget.show
                                      ? updateDegree()
                                      : setDegreeMoveOn();
                                  // setDegreeMoveOn();
                                  // _selectedSubDegree = Utils.degree[index];
                                },
                              ),
                            );
                          },
                        ).toList()),
                ),
                const Spacer(),
                Center(
                    child: ElevatedButton(
                        onPressed: _degree != null && _subDegree != null
                            ? widget.show
                                ? () => updateDegree()
                                : () => setDegreeMoveOn()
                            : null,
                        style: Constants.tonalButton(context),
                        child: Text(widget.show
                            ? 'Update'.toUpperCase()
                            : 'Continue'.toUpperCase()))),
                const SizedBox(height: 30)
              ]),
        ),
      ),
    );
  }

  updateDegree() async {
    var degree = _selectedDegree + " in " + _selectedSubDegree;
    var params = {"degree": degree, "_id": widget.id};
    // UserModel profile = await api.user(Api.updateFieldsURL, params, "");
    // if (profile.user?.degree == degree) {
    //   // int count = 0;
    //   // ignore: use_build_context_synchronously
    //   // Navigator.of(context).popUntil((_) => count++ >= 1);
    //   // ignore: use_build_context_synchronously
    //   Navigator.pop(context, "done");
    // }
  }

  setDegreeMoveOn() {
    setDegree();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (c) => const Designation(
                show: false,
                company: '',
                income: '',
                designation: '',
                id: '')));
  }

  setDegree() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        "degree", _selectedDegree + " in " + _selectedSubDegree);
  }
}
