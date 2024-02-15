import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../../network/api.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'work.dart';

// ignore: must_be_immutable
class Designation extends StatefulWidget {
  const Designation(
      {super.key,
      required this.show,
      required this.company,
      required this.income,
      required this.designation,
      required this.id});

  final bool show;
  final String company;
  final String income;
  final String designation;
  final String id;

  @override
  State<Designation> createState() => _DesignationState();
}

class _DesignationState extends State<Designation> {
  var _selectedDesignation;
  late SharedPreferences sharedPreferences;
  var _designation;
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: widget.show ? AppBar() : null,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.work, size: 80),
              const Padding(
                  padding: EdgeInsets.only(left: 8, top: 8.0),
                  child: Text("What's your designation at work?",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          letterSpacing: 0.5))),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                    children: List<Widget>.generate(
                  Utils.designation.length,
                  (int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: ChoiceChip(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        label: Text(Utils.designation[index]),
                        selected: widget.show && _designation == null
                            ? widget.designation == Utils.designation[index]
                            : _designation == null
                                ? false
                                : _designation == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _designation = selected ? index : _designation;
                          });
                          _selectedDesignation = Utils.designation[index];

                          widget.show
                              ? updateDesignation()
                              : setDesignationMoveOn();
                        },
                      ),
                    );
                  },
                ).toList()),
              ),
              const Spacer(),
              Center(
                  child: ElevatedButton(
                      onPressed: _selectedDesignation != null
                          ? widget.show
                              ? () => updateDesignation()
                              : () => setDesignationMoveOn()
                          : null,
                      style: Constants.tonalButton(context),
                      child: Text(widget.show
                          ? 'Update'.toUpperCase()
                          : 'Continue'.toUpperCase()))),
              const SizedBox(height: 30)
            ]),
      )),
    );
  }

  updateDesignation() async {
    var params = {"designation": _selectedDesignation, "_id": widget.id};
    UserModel profile = await api.user(Api.updateFieldsURL, params, "");
    if (profile.user?.designation == _selectedDesignation) {
      setDesignation();
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => Work(
                  show: widget.show,
                  company: widget.company,
                  income: widget.income,
                  id: widget.id)));
    }
  }

  setDesignationMoveOn() {
    setDesignation();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (c) => Work(
                show: false,
                company: widget.company,
                income: widget.income,
                id: widget.id)));
  }

  setDesignation() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("designation", _selectedDesignation);
  }
}
