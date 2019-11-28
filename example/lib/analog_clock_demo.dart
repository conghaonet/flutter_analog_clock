
import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';

class AnalogClockDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Container(
          color: Colors.red,
//          width: 200,
//          height: 200,
          child: AnalogClock.dark(
            hourNumberScale: 0.5,
//            borderColor: Colors.grey,
          ),
        ),
      ),
    );
  }

}

//Widget clock1() {
//  return Analo
//}