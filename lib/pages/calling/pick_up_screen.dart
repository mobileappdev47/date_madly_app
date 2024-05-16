import 'package:flutter/material.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text('Incoming........',
            style: TextStyle(color: Colors.black,fontSize:
          30),
          ),
          ElevatedButton(onPressed: () {



          }, child: Text('Pick Up')),


        ],
      ),
    );
  }
}
