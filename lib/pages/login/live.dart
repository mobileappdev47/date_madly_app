import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import 'current_city.dart';
import 'relationship_status.dart';

class Live extends StatefulWidget {
  const Live({super.key});

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  final myController = TextEditingController();
  late SharedPreferences sharedPreferences;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

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
              const Icon(Icons.house_siding, size: 80),
              const Padding(
                  padding: EdgeInsets.only(left: 8, top: 8.0),
                  child: Text("Where do you live?",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          letterSpacing: 0.5))),
              const SizedBox(height: 20),
              TextField(
                  decoration: Constants.deco("Find your current location",
                      "Find your current location"),
                  readOnly: true,
                  controller: myController,
                  onTap: () async {
                    final result = await Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const CurrentCity()));
                    if (result != null) {
                      myController.text = result;
                      setState(() {});
                    }
                  }),
              const Spacer(),
              Center(
                  child: ElevatedButton(
                      onPressed: myController.text != ""
                          ? () => setLocationMoveOn()
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

  setLocationMoveOn() {
    setLocation();
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const RelationshipStatus()));
  }

  setLocation() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("live", myController.text);
  }
}
