import 'package:date_madly_app/utils/assert_re.dart';
import 'package:flutter/material.dart';

class MapScreen3 extends StatelessWidget {
  const MapScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Image.asset(AssertRe.image_map_screen_2,
            fit: BoxFit.fill),
      ),
    );
  }
}
