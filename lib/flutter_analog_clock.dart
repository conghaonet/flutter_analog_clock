library flutter_analog_clock;

import 'dart:async';

import 'package:flutter_analog_clock/dial_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/hands_painter.dart';

/// A analog clock.
class FlutterAnalogClock extends StatefulWidget {
  final DateTime dateTime;
  final bool isLive;
  final Widget? child;
  final Color? dialColor;
  final Color? dialBorderColor;
  final double dialBorderWidthFactor;
  final Color? markingColor;
  final double markingRadiusFactor;
  final double markingWidthFactor;
  final List<String>? hourNumbers;
  final Color? hourNumberColor;

  final Color? hourHandColor;
  final Color? minuteHandColor;
  final Color? secondHandColor;
  final double hourHandWidthFactor;
  final double minuteHandWidthFactor;
  final double secondHandWidthFactor;
  final double hourHandLengthFactor;
  final double minuteHandLengthFactor;
  final double secondHandLengthFactor;

  final double hourNumberSizeFactor;
  final double hourNumberRadiusFactor;
  final Color? centerPointColor;
  final double centerPointWidthFactor;

  FlutterAnalogClock({
    super.key,
    DateTime? dateTime,
    bool? isLive,
    this.child,
    this.dialColor = Colors.white,
    this.dialBorderColor = Colors.black,
    double? dialBorderWidthFactor,
    this.markingColor = Colors.black,
    double? markingRadiusFactor,
    double? markingWidthFactor,
    this.hourNumbers = const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    this.hourNumberColor = Colors.black,
    this.hourHandColor = Colors.black,
    this.minuteHandColor = Colors.black,
    this.secondHandColor = Colors.black,
    double? hourHandWidthFactor,
    double? minuteHandWidthFactor,
    double? secondHandWidthFactor,
    double? hourHandLengthFactor,
    double? minuteHandLengthFactor,
    double? secondHandLengthFactor,
    double? hourNumberSizeFactor,
    double? hourNumberRadiusFactor,
    this.centerPointColor = Colors.black,
    double? centerPointWidthFactor,
  }) :
        this.dateTime = dateTime ?? DateTime.now(),
        this.isLive = isLive ?? true,
        this.dialBorderWidthFactor = dialBorderWidthFactor ?? 0.0,
        this.markingRadiusFactor = markingRadiusFactor ?? 1.0,
        this.markingWidthFactor = markingWidthFactor ?? 1.0,
        this.hourHandWidthFactor = hourHandWidthFactor ?? 1.0,
        this.minuteHandWidthFactor = minuteHandWidthFactor ?? 1.0,
        this.secondHandWidthFactor = secondHandWidthFactor ?? 1.0,
        this.hourHandLengthFactor = hourHandLengthFactor ?? 1.0,
        this.minuteHandLengthFactor = minuteHandLengthFactor ?? 1.0,
        this.secondHandLengthFactor = secondHandLengthFactor ?? 1.0,
        this.hourNumberSizeFactor = hourNumberSizeFactor ?? 1.0,
        this.hourNumberRadiusFactor = hourNumberRadiusFactor ?? 1.0,
        this.centerPointWidthFactor = centerPointWidthFactor ?? 1.0;

  FlutterAnalogClock.dark({
    Key? key,
    DateTime? dateTime,
    bool? isLive,
    Widget? child,
    Color? dialColor = Colors.black,
    Color? dialBorderColor = Colors.black,
    double? dialBorderWidthFactor,
    Color? markingColor = Colors.grey,
    double? markingRadiusFactor,
    double? markingWidthFactor,
    List<String>? hourNumbers,
    Color? hourNumberColor = Colors.grey,

    Color? hourHandColor = Colors.grey,
    Color? minuteHandColor = Colors.grey,
    Color? secondHandColor = Colors.grey,
    double? hourHandWidthFactor,
    double? minuteHandWidthFactor,
    double? secondHandWidthFactor,
    double? hourHandLengthFactor,
    double? minuteHandLengthFactor,
    double? secondHandLengthFactor,

    double? hourNumberSizeFactor,
    double? hourNumberRadiusFactor,
    Color? centerPointColor = Colors.grey,
    double? centerPointWidthFactor,
  }) : this(
    key: key,
    dateTime: dateTime,
    isLive: isLive,
    child: child,
    dialColor: dialColor,
    dialBorderColor: dialBorderColor,
    dialBorderWidthFactor: dialBorderWidthFactor,
    markingColor: markingColor,
    markingRadiusFactor: markingRadiusFactor,
    markingWidthFactor: markingWidthFactor,
    hourNumbers: hourNumbers,
    hourNumberColor: hourNumberColor,
    hourHandColor: hourHandColor,
    minuteHandColor: minuteHandColor,
    secondHandColor: secondHandColor,
    hourHandWidthFactor: hourHandWidthFactor,
    minuteHandWidthFactor: minuteHandWidthFactor,
    secondHandWidthFactor: secondHandWidthFactor,
    hourHandLengthFactor: hourHandLengthFactor,
    minuteHandLengthFactor: minuteHandLengthFactor,
    secondHandLengthFactor: secondHandLengthFactor,
    hourNumberSizeFactor: hourNumberSizeFactor,
    hourNumberRadiusFactor: hourNumberRadiusFactor,
    centerPointColor: centerPointColor,
    centerPointWidthFactor: centerPointWidthFactor,
  );

  @override
  State<FlutterAnalogClock> createState() => _FlutterAnalogClockState();
}

class _FlutterAnalogClockState extends State<FlutterAnalogClock> {
  Timer? _timer;
  late DateTime _dateTime;
  AnalogClockListener _listener = AnalogClockListener();
  _FlutterAnalogClockState();

  @override
  void initState() {
    super.initState();
    _dateTime = widget.dateTime;
    _timer = widget.isLive
        ? Timer.periodic(Duration(seconds: 1), (Timer timer) {
            _dateTime = _dateTime.add(Duration(seconds: 1));
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
          hourNumberSizeFactor: widget.hourNumberSizeFactor,
          hourNumberRadiusFactor: widget.hourNumberRadiusFactor,
        ),
        foregroundPainter: HandPainter(
          listener: _listener,
          dateTime: _dateTime,
          hourHandColor: widget.hourHandColor,
          minuteHandColor: widget.minuteHandColor,
          secondHandColor: widget.secondHandColor,
          hourHandWidthFactor: widget.hourHandWidthFactor,
          minuteHandWidthFactor: widget.minuteHandWidthFactor,
          secondHandWidthFactor: widget.secondHandWidthFactor,
          hourHandLengthFactor: widget.hourHandLengthFactor,
          minuteHandLengthFactor: widget.minuteHandLengthFactor,
          secondHandLengthFactor: widget.secondHandLengthFactor,
          centerPointColor: widget.centerPointColor,
          centerPointWidthFactor: widget.centerPointWidthFactor,
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