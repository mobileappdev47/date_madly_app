import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import 'live.dart';

class Tall extends StatefulWidget {
  const Tall({super.key});

  @override
  State<Tall> createState() => _TallState();
}

class _TallState extends State<Tall> {
  double _value = 160;
  late int? startFeet = 5;
  late int? startInch = 3;
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
                const Icon(Icons.height, size: 80),
                const Padding(
                    padding: EdgeInsets.only(left: 8, top: 8.0),
                    child: Text("How tall you are?",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            letterSpacing: 0.5))),
                const SizedBox(height: 20),
                const Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
                    child: Text("Selected Height (in cms)")),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Text("${_value.round()} cm",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))),
                const Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
                    child: Text("Selected Height (in feets and inches)")),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Text("$startFeet'$startInch''",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))),
                const SizedBox(height: 20),
                Slider(
                  min: 134,
                  max: 213,
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                    getStartHeight(value.round());
                  },
                ),
                const Spacer(),
                Center(
                    child: ElevatedButton(
                        onPressed: () => setHeightMoveOn(),
                        style: Constants.tonalButton(context),
                        child: Text('Continue'.toUpperCase()))),
                const SizedBox(height: 30)
              ]),
        ),
      ),
    );
  }

  setHeightMoveOn() {
    setHeight();
    Navigator.push(context, MaterialPageRoute(builder: (c) => const Live()));
  }

  setHeight() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("height", _value.round());
  }

  getStartHeight(int? height) {
    switch (height) {
      case 134:
        startFeet = 4;
        startInch = 5;
        break;
      case 135:
        startFeet = 4;
        startInch = 5;
        break;
      case 136:
        startFeet = 4;
        startInch = 5;
        break;
      case 137:
        startFeet = 4;
        startInch = 6;
        break;
      case 138:
        startFeet = 4;
        startInch = 6;
        break;
      case 139:
        startFeet = 4;
        startInch = 7;
        break;
      case 140:
        startFeet = 4;
        startInch = 7;
        break;
      case 141:
        startFeet = 4;
        startInch = 7;
        break;
      case 142:
        startFeet = 4;
        startInch = 8;
        break;
      case 143:
        startFeet = 4;
        startInch = 8;
        break;
      case 144:
        startFeet = 4;
        startInch = 9;
        break;
      case 145:
        startFeet = 4;
        startInch = 9;
        break;
      case 146:
        startFeet = 4;
        startInch = 9;
        break;
      case 147:
        startFeet = 4;
        startInch = 10;
        break;
      case 148:
        startFeet = 4;
        startInch = 10;
        break;
      case 149:
        startFeet = 4;
        startInch = 11;
        break;
      case 150:
        startFeet = 4;
        startInch = 11;
        break;
      case 151:
        startFeet = 4;
        startInch = 11;
        break;
      case 152:
        startFeet = 5;
        startInch = 0;
        break;
      case 153:
        startFeet = 5;
        startInch = 0;
        break;
      case 154:
        startFeet = 5;
        startInch = 1;
        break;
      case 155:
        startFeet = 5;
        startInch = 1;
        break;
      case 156:
        startFeet = 5;
        startInch = 1;
        break;
      case 157:
        startFeet = 5;
        startInch = 2;
        break;
      case 158:
        startFeet = 5;
        startInch = 2;
        break;
      case 159:
        startFeet = 5;
        startInch = 2;
        break;
      case 160:
        startFeet = 5;
        startInch = 3;
        break;
      case 161:
        startFeet = 5;
        startInch = 3;
        break;
      case 162:
        startFeet = 5;
        startInch = 4;
        break;
      case 163:
        startFeet = 5;
        startInch = 4;
        break;
      case 164:
        startFeet = 5;
        startInch = 4;
        break;
      case 165:
        startFeet = 5;
        startInch = 5;
        break;
      case 166:
        startFeet = 5;
        startInch = 5;
        break;
      case 167:
        startFeet = 5;
        startInch = 6;
        break;
      case 168:
        startFeet = 5;
        startInch = 6;
        break;
      case 169:
        startFeet = 5;
        startInch = 6;
        break;
      case 170:
        startFeet = 5;
        startInch = 7;
        break;
      case 171:
        startFeet = 5;
        startInch = 7;
        break;
      case 172:
        startFeet = 5;
        startInch = 8;
        break;
      case 173:
        startFeet = 5;
        startInch = 8;
        break;
      case 174:
        startFeet = 5;
        startInch = 8;
        break;
      case 175:
        startFeet = 5;
        startInch = 9;
        break;
      case 176:
        startFeet = 5;
        startInch = 9;
        break;
      case 177:
        startFeet = 5;
        startInch = 10;
        break;
      case 178:
        startFeet = 5;
        startInch = 10;
        break;
      case 179:
        startFeet = 5;
        startInch = 10;
        break;
      case 180:
        startFeet = 5;
        startInch = 11;
        break;
      case 181:
        startFeet = 5;
        startInch = 11;
        break;
      case 182:
        startFeet = 6;
        startInch = 0;
        break;
      case 183:
        startFeet = 6;
        startInch = 0;
        break;
      case 184:
        startFeet = 6;
        startInch = 0;
        break;
      case 185:
        startFeet = 6;
        startInch = 1;
        break;
      case 186:
        startFeet = 6;
        startInch = 1;
        break;
      case 187:
        startFeet = 6;
        startInch = 2;
        break;
      case 188:
        startFeet = 6;
        startInch = 2;
        break;
      case 189:
        startFeet = 6;
        startInch = 2;
        break;
      case 190:
        startFeet = 6;
        startInch = 3;
        break;
      case 191:
        startFeet = 6;
        startInch = 3;
        break;
      case 192:
        startFeet = 6;
        startInch = 3;
        break;
      case 193:
        startFeet = 6;
        startInch = 4;
        break;
      case 194:
        startFeet = 6;
        startInch = 4;
        break;
      case 195:
        startFeet = 6;
        startInch = 5;
        break;
      case 196:
        startFeet = 6;
        startInch = 5;
        break;
      case 197:
        startFeet = 6;
        startInch = 5;
        break;
      case 198:
        startFeet = 6;
        startInch = 6;
        break;
      case 199:
        startFeet = 6;
        startInch = 6;
        break;
      case 200:
        startFeet = 6;
        startInch = 7;
        break;
      case 201:
        startFeet = 6;
        startInch = 7;
        break;
      case 202:
        startFeet = 6;
        startInch = 7;
        break;
      case 203:
        startFeet = 6;
        startInch = 8;
        break;
      case 204:
        startFeet = 6;
        startInch = 8;
        break;
      case 205:
        startFeet = 6;
        startInch = 9;
        break;
      case 206:
        startFeet = 6;
        startInch = 9;
        break;
      case 207:
        startFeet = 6;
        startInch = 9;
        break;
      case 208:
        startFeet = 6;
        startInch = 10;
        break;
      case 209:
        startFeet = 6;
        startInch = 10;
        break;
      case 210:
        startFeet = 6;
        startInch = 11;
        break;
      case 211:
        startFeet = 6;
        startInch = 11;
        break;
      case 212:
        startFeet = 6;
        startInch = 11;
        break;
      case 213:
        startFeet = 7;
        startInch = 0;
        break;
      default:
    }
  }
}
