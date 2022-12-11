library flutter_analog_clock;

import 'dart:async';

import 'package:flutter_analog_clock/analog_clock_dial.dart';
import 'package:flutter_analog_clock/flutter_analog_clock_painter.dart';
import 'package:flutter/material.dart';

/// A analog clock.
class FlutterAnalogClock extends StatefulWidget {
  final DateTime? dateTime;
  final Color? dialColor;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color numberColor;
  final Color borderColor;
  final Color markingColor;
  final Color centerPointColor;
  final bool showBorder;
  final bool showTicks;
  final bool showMinuteHand;
  final bool showSecondHand;
  final bool showNumber;
  final double? borderWidth;
  final double hourNumberScale;
  final List<String> hourNumbers;
  final bool isLive;
  final BoxDecoration decoration;
  final Widget? child;
  final double? markingRadiusScale;
  final double? markingWidthScale;
  final double? borderWidthFactor;

  const FlutterAnalogClock({
    super.key,
    this.dateTime,
    this.dialColor = Colors.white,
    this.hourHandColor = Colors.black,
    this.minuteHandColor = Colors.black,
    this.secondHandColor = Colors.black,
    this.numberColor = Colors.black,
    this.borderColor = Colors.black,
    this.markingColor = Colors.black,
    this.centerPointColor = Colors.black,
    this.showBorder = true,
    this.showTicks = true,
    this.showMinuteHand = true,
    this.showSecondHand = true,
    this.showNumber = true,
    this.borderWidth,
    this.hourNumberScale = 1.0,
    this.hourNumbers = FlutterAnalogClockPainter.defaultHourNumbers,
    this.isLive = true,
    this.decoration = const BoxDecoration(),
    this.child,
    this.markingRadiusScale,
    this.markingWidthScale,
    this.borderWidthFactor,
  });
  const FlutterAnalogClock.dark({
    super.key,
    this.dateTime,
    this.dialColor = Colors.black,
    this.hourHandColor = Colors.grey,
    this.minuteHandColor = Colors.grey,
    this.secondHandColor = Colors.grey,
    this.numberColor = Colors.grey,
    this.borderColor = Colors.black,
    this.markingColor = Colors.grey,
    this.centerPointColor = Colors.grey,
    this.showBorder = true,
    this.showTicks = true,
    this.showMinuteHand = true,
    this.showSecondHand = true,
    this.showNumber = true,
    this.borderWidth = 0.0,
    this.hourNumberScale = 1.0,
    this.hourNumbers = FlutterAnalogClockPainter.defaultHourNumbers,
    this.isLive = true,
    this.decoration = const BoxDecoration(),
    this.child,
    this.markingRadiusScale,
    this.markingWidthScale,
    this.borderWidthFactor,
  });

  @override
  _FlutterAnalogClockState createState() =>
      _FlutterAnalogClockState(this.dateTime);
}

class _FlutterAnalogClockState extends State<FlutterAnalogClock> {
  Timer? _timer;
  DateTime? _dateTime;
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
      child: Stack(
        children: [
          AnalogClockDial(
            child: widget.child,
            dialColor: widget.dialColor,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
            borderWidthFactor: widget.borderWidthFactor,
            markingColor: widget.markingColor,
            markingRadiusScale: widget.markingRadiusScale ?? 0.95,
            markingWidthScale: widget.markingWidthScale ?? 1.0,
          ),
        ],
      ),
    );
/*
    return Container(
      decoration: widget.decoration,
      child: CustomPaint(
        child: widget.child,
        painter: FlutterAnalogClockPainter(
          _dateTime ?? DateTime.now(),
          dialPlateColor: widget.dialPlateColor,
          hourHandColor: widget.hourHandColor,
          minuteHandColor: widget.minuteHandColor,
          secondHandColor: widget.secondHandColor,
          numberColor: widget.numberColor,
          borderColor: widget.borderColor,
          tickColor: widget.tickColor,
          centerPointColor: widget.centerPointColor,
          showBorder: widget.showBorder,
          showTicks: widget.showTicks,
          showMinuteHand: widget.showMinuteHand,
          showSecondHand: widget.showSecondHand,
          showNumber: widget.showNumber,
          borderWidth: widget.borderWidth,
          hourNumberScale: widget.hourNumberScale,
          hourNumbers: widget.hourNumbers,
        ),
      ),
    );
*/
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
