library flutter_analog_clock;

import 'dart:async';

import 'package:flutter_analog_clock/dial_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/hands_painter.dart';

/// A analog clock.
class FlutterAnalogClock extends StatefulWidget {
  final DateTime? dateTime;
  final Widget? child;
  final Color dialColor;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color hourNumberColor;
  final Color dialBorderColor;
  final Color markingColor;
  final Color centerPointColor;
  final bool showBorder;
  final bool showTicks;
  final bool showMinuteHand;
  final bool showSecondHand;
  final bool showNumber;
  final double hourNumberScale;
  final List<String> hourNumbers;
  final bool isLive;
  final double dialBorderWidthFactor;

  const FlutterAnalogClock({
    super.key,
    this.child,
    this.dateTime,
    this.dialColor = Colors.white,
    this.hourHandColor = Colors.black,
    this.minuteHandColor = Colors.black,
    this.secondHandColor = Colors.black,
    this.hourNumberColor = Colors.black,
    this.dialBorderColor = Colors.black,
    this.markingColor = Colors.black,
    this.centerPointColor = Colors.black,
    this.showBorder = true,
    this.showTicks = true,
    this.showMinuteHand = true,
    this.showSecondHand = true,
    this.showNumber = true,
    this.hourNumberScale = 1.0,
    this.hourNumbers = const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    this.isLive = true,
    this.dialBorderWidthFactor = 0.02,
  });
  const FlutterAnalogClock.dark({
    super.key,
    this.dateTime,
    this.dialColor = Colors.black,
    this.hourHandColor = Colors.grey,
    this.minuteHandColor = Colors.grey,
    this.secondHandColor = Colors.grey,
    this.hourNumberColor = Colors.grey,
    this.dialBorderColor = Colors.black,
    this.markingColor = Colors.grey,
    this.centerPointColor = Colors.grey,
    this.showBorder = true,
    this.showTicks = true,
    this.showMinuteHand = true,
    this.showSecondHand = true,
    this.showNumber = true,
    this.hourNumberScale = 1.0,
    this.hourNumbers = const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    this.isLive = true,
    this.child,
    this.dialBorderWidthFactor = 0.02,
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
          dialBorderWidthFactor: null,
          markingColor: widget.markingColor,
          markingRadiusFactor: 0.95,
          markingWidthFactor: 1.0,
          hourNumberColor: widget.hourNumberColor,
        ),
        foregroundPainter: HandPainter(
          listener: _listener,
          dateTime: _dateTime ?? DateTime.now(),
          hourHandColor: widget.hourHandColor,
          minuteHandColor: widget.minuteHandColor,
          secondHandColor: widget.secondHandColor,
        ),
        /*painter: FlutterAnalogClockPainter(
          _dateTime ?? DateTime.now(),
          dialColor: widget.dialColor,
          hourHandColor: widget.hourHandColor,
          minuteHandColor: widget.minuteHandColor,
          secondHandColor: widget.secondHandColor,
          numberColor: widget.numberColor,
          borderColor: widget.borderColor,
          markingColor: widget.markingColor,
          centerPointColor: widget.centerPointColor,
          showBorder: widget.showBorder,
          showTicks: widget.showTicks,
          showMinuteHand: widget.showMinuteHand,
          showSecondHand: widget.showSecondHand,
          showNumber: widget.showNumber,
          borderWidth: widget.borderWidth,
          hourNumberScale: widget.hourNumberScale,
          hourNumbers: widget.hourNumbers,
        ),*/
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