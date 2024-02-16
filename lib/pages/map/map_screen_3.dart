import 'package:flutter/material.dart';

class MapScreen3 extends StatelessWidget {
  const MapScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Image.asset("assets/icons/image_map_screen_2.png",
            fit: BoxFit.fill),
      ),
    );
  }
}
