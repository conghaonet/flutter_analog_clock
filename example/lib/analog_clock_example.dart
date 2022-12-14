import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_analog_clock/flutter_analog_clock.dart';
class AnalogClockDemo extends StatefulWidget {
  const AnalogClockDemo({super.key});

  @override
  State<AnalogClockDemo> createState() => _AnalogClockDemoState();
}

class _AnalogClockDemoState extends State<AnalogClockDemo> {
  bool _isKeepTime = false;
  DateTime? _dateTime;
  Color? _dialColor = Colors.white;
  Color? _dialBorderColor = Colors.black;
  double? _dialBorderWidthFactor = 0.01;
  Color? _markingColor = Colors.black;
  double? _markingRadiusFactor;
  double? _markingWidthFactor;
  Color? _hourNumberColor = Colors.black;
  double? _hourNumberSizeFactor;
  double? _hourNumberRadiusFactor;
  Color? _hourHandColor = Colors.black;
  Color? _minuteHandColor = Colors.black;
  Color? _secondHandColor = Colors.black;
  Color? _centerPointColor = Colors.black;
  double? _hourHandWidthFactor;
  double? _hourHandLengthFactor;
  double? _minuteHandWidthFactor;
  double? _minuteHandLengthFactor;
  double? _secondHandWidthFactor;
  double? _secondHandLengthFactor;
  double? _centerPointWidthFactor;
  final math.Random _random = math.Random();
  final GlobalKey<AnalogClockState> clockKey = GlobalKey();
  // static const List<Color> colors = [
  //   Colors.black, Colors.white, Colors.blue, Colors.amber, Colors.green,
  //   Colors.red, Colors.yellow, Colors.cyan, Colors.brown, Colors.indigo,
  //   Colors.lime, Colors.orange, Colors.pink, Colors.purple, Colors.teal,
  // ];
  static const List<Color> colors = [
    Colors.black, Colors.white, Colors.red, Colors.green, Colors.blue,
    Colors.yellow, Colors.purple,
  ];

  SettingGroup _selectedSettingGroup = SettingGroup.values[1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade300,
              child: AnalogClock(
                key: clockKey,
                dateTime: _dateTime,
                isKeepTime: _isKeepTime,
                dialColor: _dialColor,
                dialBorderColor: _dialBorderColor,
                dialBorderWidthFactor: _dialBorderWidthFactor,
                markingColor: _markingColor,
                markingRadiusFactor: _markingRadiusFactor,
                markingWidthFactor: _markingWidthFactor,
                hourNumberColor: _hourNumberColor,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildSettingGroup(),
                )
/*
                Column(
                  children: [
                    _buildFactorSlider(),
                    _buildColorPicker(),
                    ElevatedButton(
                      onPressed: () {
                        clockKey.currentState?.isKeepTime = !clockKey.currentState!.isKeepTime;
                      },
                      child: Text('isLive'),
                    ),
                  ],
                ),
*/
              ),
            ),
            _buildFooterButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterButtons() {
    return Container(
      color: Colors.grey.shade300,
      height: 50,
      child: Row(
        children: List.generate(SettingGroup.values.length, (index) {
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedSettingGroup = SettingGroup.values[index];
                });
              },
              child: Center(
                child: Text(SettingGroup.values[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: SettingGroup.values[index] == _selectedSettingGroup ? Colors.blueAccent : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },),
      ),
    );
  }

  Widget _buildSettingGroup() {
    switch(_selectedSettingGroup) {
      case SettingGroup.dial:
        return _buildDialSetting();
      case SettingGroup.marking:
        return _buildMarkSetting();
      // case SettingGroup.number:
      //   return _buildDialSetting();
      // case SettingGroup.hands:
      //   return _buildDialSetting();
      default:
        return const Text('Error!');
    }
  }

  Widget _buildDialSetting() {
    return Column(
      children: [
        Row(
          children: [
            const Text('Dial: '),
            Expanded(child: _buildColorPicker(PartColor.dial)),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            const Text('Border: '),
            Expanded(child: _buildColorPicker(PartColor.dialBorder)),
          ],
        ),
        Row(
          children: [
            const Text('Border: '),
            _buildFactorSlider(PartFactor.borderWidth),
          ],
        ),
      ],
    );
  }
  Widget _buildMarkSetting() {
    return Column(
      children: [
        Row(
          children: [
            const Text('Mark: '),
            Expanded(child: _buildColorPicker(PartColor.marking)),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            const Text('Radius: '),
            _buildFactorSlider(PartFactor.markingRadius),
          ],
        ),
        // Row(
        //   children: [
        //     const Text('Width: '),
        //     _buildFactorSlider(PartFactor.markingWidth),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildColorPicker(PartColor partColor) {
    return Wrap(
      children: List.generate(colors.length, growable: false, (index) {
        return InkWell(
          onTap: () {
            setState(() {
              switch(partColor) {
                case PartColor.dial:
                  _dialColor = colors[index];
                  break;
                case PartColor.dialBorder:
                  _dialBorderColor = colors[index];
                  break;
                case PartColor.marking:
                  _markingColor = colors[index];
                  break;
                case PartColor.hourNumber:
                  _hourNumberColor = colors[index];
                  break;
                case PartColor.hourHand:
                  _hourHandColor = colors[index];
                  break;
                case PartColor.minuteHand:
                  _minuteHandColor = colors[index];
                  break;
                case PartColor.secondHand:
                  _secondHandColor = colors[index];
                  break;
                case PartColor.centerPoint:
                  _centerPointColor = colors[index];
                  break;
                default:
                  break;
              }
            });
          },
          child: Container(
            width: 40,
            height: 40,
            color: colors[index],
          ),
        );
      },
      ),
    );
  }

  Widget _buildFactorSlider(PartFactor partFactor) {
    double? value;
    double maxValue = 2.0;
    double defaultValue = 1.0;
    void switchValue(bool isChanged) {
      switch(partFactor) {
        case PartFactor.borderWidth:
          if(isChanged) {
            _dialBorderWidthFactor = value;
          } else {
            value = _dialBorderWidthFactor;
            maxValue = 1.0;
            defaultValue = 0.0;
          }
          break;
        case PartFactor.markingRadius:
          isChanged ? _markingRadiusFactor = value : value = _markingRadiusFactor;
          break;
        case PartFactor.markingWidth:
          isChanged ? _markingWidthFactor = value : value = _markingWidthFactor;
          break;
        case PartFactor.numberSize:
          isChanged ? _hourNumberSizeFactor = value : value = _hourNumberSizeFactor;
          break;
        case PartFactor.numberRadius:
          isChanged ? _hourNumberRadiusFactor = value : value = _hourNumberRadiusFactor;
          break;
        case PartFactor.hourWidth:
          isChanged ? _hourHandWidthFactor = value : value = _hourHandWidthFactor;
          break;
        case PartFactor.minuteWidth:
          isChanged ? _minuteHandWidthFactor = value : value = _minuteHandWidthFactor;
          break;
        case PartFactor.secondWidth:
          isChanged ? _secondHandWidthFactor = value : value = _secondHandWidthFactor;
          break;
        case PartFactor.hourLength:
          isChanged ? _hourHandLengthFactor = value : value = _hourHandLengthFactor;
          break;
        case PartFactor.minuteLength:
          isChanged ? _minuteHandLengthFactor = value : value = _minuteHandLengthFactor;
          break;
        case PartFactor.secondLength:
          isChanged ? _secondHandLengthFactor = value : value = _secondHandLengthFactor;
          break;
        case PartFactor.centerPointWidth:
          isChanged ? _centerPointWidthFactor = value : value = _centerPointWidthFactor;
          break;
        default:
          break;
      }
    }
    switchValue(false);
    return Expanded(
      child: Slider(
        value: value ?? defaultValue,
        min: 0,
        max: maxValue,
        divisions: 100,
        label: (value ?? defaultValue).toString(),
        onChanged: (newValue) {
          setState(() {
            value = newValue;
            switchValue(true);
          });
        },
      ),
    );
  }

  Color getRandomColor() => Color.fromARGB(255, _random.nextInt(256), _random.nextInt(256), _random.nextInt(256));
}

enum SettingGroup {
  dial('Dial'),
  marking('Marking'),
  number('Number'),
  hands('Hands');
  final String name;
  const SettingGroup(this.name);
}
enum PartColor {
  dial, dialBorder, marking, hourNumber, hourHand, minuteHand, secondHand, centerPoint,
}
enum PartFactor {
  borderWidth, markingRadius, markingWidth, numberSize, numberRadius, hourWidth,
  minuteWidth, secondWidth, hourLength, minuteLength, secondLength, centerPointWidth,
}