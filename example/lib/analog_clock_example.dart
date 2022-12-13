import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_analog_clock/flutter_analog_clock.dart';
class AnalogClockDemo extends StatefulWidget {
  const AnalogClockDemo({super.key});

  @override
  State<AnalogClockDemo> createState() => _AnalogClockDemoState();
}

class _AnalogClockDemoState extends State<AnalogClockDemo> {
  Color? _dialColor;
  Color? _dialBorderColor;
  double? _dialBorderWidthFactor;
  Color? _markingColor;
  double? _markingRadiusFactor;
  double? _markingWidthFactor;
  Color? _hourNumberColor;
  double? _hourNumberSizeFactor;
  Color? _hourHandColor;
  Color? _minuteHandColor;
  Color? _secondHandColor;
  double? _hourHandWidthFactor;
  double? _hourHandLengthFactor;
  double? _minuteHandWidthFactor;
  double? _minuteHandLengthFactor;
  double? _secondHandWidthFactor;
  double? _secondHandLengthFactor;

  final math.Random _random = math.Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnalogClock(
          // dateTime: DateTime(2022, DateTime.december, 13, 15, 17, 18),
          // isLive: false,
          // hourHandColor: Colors.red,
          // minuteHandColor: Colors.green,
          // secondHandColor: Colors.blue,
          // centerPointColor: Colors.amberAccent,
        ),
/*
        child: SingleChildScrollView(
          child: Column(
            children: [
              FlutterAnalogClock(
                dateTime: DateTime(2022, DateTime.december, 13, 15, 17, 19),
                isLive: false,
                dialColor: _dialColor,
                dialBorderColor: _dialBorderColor,
                dialBorderWidthFactor: _dialBorderWidthFactor,
                markingColor: _markingColor,
                markingRadiusFactor: _markingRadiusFactor,
                markingWidthFactor: _markingWidthFactor,
                hourNumbers: const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
                hourNumberColor: _hourNumberColor,
                hourNumberSizeFactor: _hourNumberSizeFactor,
                hourNumberRadiusFactor: 1,
                hourHandColor: _hourHandColor,
                minuteHandColor: _minuteHandColor,
                secondHandColor: _secondHandColor,
                hourHandWidthFactor: _hourHandWidthFactor,
                hourHandLengthFactor: _hourHandLengthFactor,
                minuteHandWidthFactor: _minuteHandWidthFactor,
                minuteHandLengthFactor: _minuteHandLengthFactor,
                secondHandWidthFactor: _secondHandWidthFactor,
                secondHandLengthFactor: _secondHandLengthFactor,
              ),
              Wrap(
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => _dialColor = getRandomColor()),
                    child: const Text('Dial color'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _dialBorderColor = getRandomColor()),
                    child: const Text('Border color'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _dialBorderWidthFactor = _random.nextDouble()),
                    child: const Text('Border factor'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _hourNumberColor = getRandomColor()),
                    child: const Text('Hour Number color'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _hourNumberSizeFactor = _random.nextDouble()),
                    child: const Text('Hour Number factor'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _markingColor = getRandomColor()),
                    child: const Text('Markings color'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _markingRadiusFactor = _random.nextDouble()),
                    child: const Text('Marking radius factor'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _markingWidthFactor = _random.nextDouble()),
                    child: const Text('Marking width factor'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _hourHandColor = getRandomColor()),
                    child: const Text('Hour hand color'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _minuteHandColor = getRandomColor()),
                    child: const Text('Minute hand color'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _secondHandColor = getRandomColor()),
                    child: const Text('Second hand color'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _hourHandWidthFactor = _random.nextDouble()),
                    child: const Text('Hour hand width factor'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _hourHandLengthFactor = _random.nextDouble()),
                    child: const Text('Hour hand length factor'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _minuteHandWidthFactor = _random.nextDouble()),
                    child: const Text('Minute hand width factor'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _minuteHandLengthFactor = _random.nextDouble()),
                    child: const Text('Minute hand length factor'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _secondHandWidthFactor = _random.nextDouble()),
                    child: const Text('Second hand width factor'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _secondHandLengthFactor = _random.nextDouble()),
                    child: const Text('Second hand length factor'),
                  ),
                ]
              ),
            ],
          ),
        ),
*/
      ),
    );
  }

  Color getRandomColor() => Color.fromARGB(255, _random.nextInt(256), _random.nextInt(256), _random.nextInt(256));

}

Widget buildClock1() {
  return AnalogClock();
}

Widget buildClock2() {
  DateTime dateTime = DateTime.now();
  dateTime = dateTime.add(const Duration(hours: 8));
  return AnalogClock.dark(
    dateTime: dateTime,
    child: const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 100),
        child: Text(
          'GMT + 8',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget buildClock3() {
  DateTime dateTime = DateTime.now();
  dateTime = dateTime.add(const Duration(hours: -8));
  return AnalogClock(
    dateTime: dateTime,
    dialColor: Colors.green,
    hourHandColor: Colors.red,
    minuteHandColor: Colors.purple,
    secondHandColor: Colors.blue.shade200,
    dialBorderColor: Colors.green.shade700,
    markingColor: Colors.white,
    centerPointColor: Colors.yellow,
    child: const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: Text(
          'GMT - 8',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget buildClock4() {
  return AnalogClock(
    hourNumbers: const ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII'],
    dialColor: Colors.yellow,
    hourHandColor: Colors.red,
    minuteHandColor: Colors.green,
    markingColor: Colors.green,
    hourNumberColor: Colors.blue,
    centerPointColor: Colors.white,
  );
}

Widget buildClock5() {
  return AnalogClock(
    dialColor: Colors.blue,
    hourHandColor: Colors.white,
    centerPointColor: Colors.white,
  );
}

Widget buildClock6() {
  return AnalogClock(
    hourNumbers: const ['', '', '3', '', '', '6', '', '', '9', '', '', '12'],
    dialColor: Colors.red,
    hourHandColor: Colors.white,
    minuteHandColor: Colors.white,
    secondHandColor: Colors.white,
    centerPointColor: Colors.white,
    dialBorderColor: Colors.red.shade700,
    markingColor: Colors.blue.shade900,
  );
}