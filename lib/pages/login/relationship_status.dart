import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'degree.dart';

class RelationshipStatus extends StatefulWidget {
  const RelationshipStatus({super.key});

  @override
  State<RelationshipStatus> createState() => _RelationshipStatusState();
}

class _RelationshipStatusState extends State<RelationshipStatus> {
  var _selectedRelation;
  var _relation;
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.favorite, size: 80),
              const Padding(
                  padding: EdgeInsets.only(left: 8, top: 8.0),
                  child: Text("What is your relationship status?",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          letterSpacing: 0.5))),
              const SizedBox(height: 20),
              Wrap(
                  children: List<Widget>.generate(
                Utils.relationStatus.length,
                (int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: ChoiceChip(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      label: Text(Utils.relationStatus[index]),
                      selected: _relation == null ? false : _relation == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _relation = selected ? index : _relation;
                        });
                        _selectedRelation = Utils.relationStatus[index];
                        setRelationMoveOn();
                      },
                    ),
                  );
                },
              ).toList()),
              const Spacer(),
              Center(
                  child: ElevatedButton(
                      onPressed: _selectedRelation != null
                          ? () => setRelationMoveOn()
                          : null,
                      style: Constants.tonalButton(context),
                      child: Text('Continue'.toUpperCase()))),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  setRelationMoveOn() {
    setRelation();
    Navigator.push(context,
        MaterialPageRoute(builder: (c) => const Degree(show: false, id: '')));
  }

  setRelation() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("relationStatus", _selectedRelation);
  }
}
