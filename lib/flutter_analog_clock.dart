library flutter_analog_clock;

import 'dart:async';

import 'package:flutter_analog_clock/dial_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/hands_painter.dart';

/// A analog clock.
class FlutterAnalogClock extends StatefulWidget {
  final DateTime? dateTime;
  final bool isLive;
  final Widget? child;
  final Color dialColor;
  final Color dialBorderColor;
  final double dialBorderWidthFactor;
  final Color markingColor;
  final double markingRadiusFactor;
  final double markingWidthFactor;
  final List<String> hourNumbers;
  final Color hourNumberColor;

  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final double hourHandWidthFactor;
  final double minuteHandWidthFactor;
  final double secondHandWidthFactor;
  final double hourHandLengthFactor;
  final double minuteHandLengthFactor;
  final double secondHandLengthFactor;

  final Color centerPointColor;
  final double hourNumberScale;

  const FlutterAnalogClock({
    super.key,
    this.dateTime,
    this.isLive = true,
    this.child,
    this.dialColor = Colors.white,
    this.dialBorderColor = Colors.black,
    this.dialBorderWidthFactor = 0.02,
    this.markingColor = Colors.black,
    this.markingRadiusFactor = 1.0,
    this.markingWidthFactor = 1.0,
    this.hourNumbers = const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    this.hourNumberColor = Colors.black,

    this.hourHandColor = Colors.black,
    this.minuteHandColor = Colors.black,
    this.secondHandColor = Colors.black,
    this.hourHandWidthFactor = 1.0,
    this.minuteHandWidthFactor = 1.0,
    this.secondHandWidthFactor = 1.0,
    this.hourHandLengthFactor = 1.0,
    this.minuteHandLengthFactor = 1.0,
    this.secondHandLengthFactor = 1.0,

    this.centerPointColor = Colors.black,
    this.hourNumberScale = 1.0,
  });
  const FlutterAnalogClock.dark({
    super.key,
    this.dateTime,
    this.isLive = true,
    this.child,
    this.dialColor = Colors.black,
    this.dialBorderColor = Colors.black,
    this.dialBorderWidthFactor = 0.02,
    this.markingColor = Colors.grey,
    this.markingRadiusFactor = 1.0,
    this.markingWidthFactor = 1.0,
    this.hourNumbers = const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    this.hourNumberColor = Colors.grey,

    this.hourHandColor = Colors.grey,
    this.minuteHandColor = Colors.grey,
    this.secondHandColor = Colors.grey,
    this.hourHandWidthFactor = 1.0,
    this.minuteHandWidthFactor = 1.0,
    this.secondHandWidthFactor = 1.0,
    this.hourHandLengthFactor = 1.0,
    this.minuteHandLengthFactor = 1.0,
    this.secondHandLengthFactor = 1.0,

    this.centerPointColor = Colors.grey,
    this.hourNumberScale = 1.0,
  });

  @override
  _FlutterAnalogClockState createState() =>
      _FlutterAnalogClockState(this.dateTime);
}

class _FlutterAnalogClockState extends State<FlutterAnalogClock> {
  Timer? _timer;
  DateTime? _dateTime;
  AnalogClockListener _listener = AnalogClockListener();
  _FlutterAnalogClockState(this._dateTime);

  @override
  void initState() {
    super.initState();
    if (!widget.isLive && this._dateTime == null) {
      this._dateTime = DateTime.now();
    }
    _timer = widget.isLive
        ? Timer.periodic(Duration(seconds: 1), (Timer timer) {
            _dateTime = _dateTime?.add(Duration(seconds: 1));
            if (mounted) {
              setState(() {});
            }
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        child: widget.child,
        painter: DialPainter(
          listener: _listener,
          dialColor: widget.dialColor,
          dialBorderColor: widget.dialBorderColor,
          dialBorderWidthFactor: widget.dialBorderWidthFactor,
          markingColor: widget.markingColor,
          markingRadiusFactor: widget.markingRadiusFactor,
          markingWidthFactor: widget.markingWidthFactor,
          hourNumbers: widget.hourNumbers,
          hourNumberColor: widget.hourNumberColor,
        ),
        foregroundPainter: HandPainter(
          listener: _listener,
          dateTime: _dateTime ?? DateTime.now(),
          hourHandColor: widget.hourHandColor,
          minuteHandColor: widget.minuteHandColor,
          secondHandColor: widget.secondHandColor,
          hourHandWidthFactor: 1.0,
          minuteHandWidthFactor: 1.0,
          secondHandWidthFactor: 1.0,
          hourHandLengthFactor: 1.0,
          minuteHandLengthFactor: 1.0,
          secondHandLengthFactor: 1.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class AnalogClockListener extends Listenable {
  double dialRadius = 0.0;
  double markingRadius = 0.0;
  double bigMarkingWidth = 0.0;
  double maxHourNumberSide = 0.0;
  double hourNumberRadius = 0.0;

  @override
  void addListener(VoidCallback listener) {
  }

  @override
  void removeListener(VoidCallback listener) {
  }

}