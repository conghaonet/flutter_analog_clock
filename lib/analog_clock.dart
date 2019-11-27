library analog_clock;

import 'dart:async';

import 'package:analog_clock/analog_clock_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';


/// A analog clock.
class AnalogClock extends StatefulWidget {
  final DateTime dateTime;
  final Color dialPlateColor;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color numberColor;
  final Color borderColor;
  final Color tickColor;
  final Color centerPointColor;
  final List<String> hourNumbers;
  final bool showBorder;
  final bool showTicks;
  final bool showMinuteHand;
  final bool showSecondHand;
  final bool showNumber;
  final double borderWidth;
  final bool isLive;
  final double width;
  final double height;
  final BoxDecoration decoration;
  final Widget child;

  const AnalogClock({
    this.dateTime,
    this.dialPlateColor = Colors.transparent,
    this.hourHandColor = Colors.black,
    this.minuteHandColor = Colors.black,
    this.secondHandColor = Colors.black,
    this.numberColor = Colors.black,
    this.borderColor = Colors.black,
    this.tickColor = Colors.black,
    this.centerPointColor = Colors.black,
    this.hourNumbers = AnalogClockPainter.defaultHourNumbers,
    this.showBorder = true,
    this.showTicks = true,
    this.showMinuteHand = true,
    this.showSecondHand = true,
    this.showNumber = true,
    this.borderWidth,
    this.isLive = true,
    this.width = double.infinity,
    this.height = double.infinity,
    this.decoration = const BoxDecoration(),
    this.child,
    Key key
  }): super(key: key);

  @override
  _AnalogClockState createState() => _AnalogClockState(this.dateTime);
}

class _AnalogClockState extends State<AnalogClock> {
  Timer _timer;
  DateTime _dateTime;
  _AnalogClockState(this._dateTime);

  @override
  void initState() {
    super.initState();
    if(!widget.isLive && this._dateTime==null) this._dateTime = DateTime.now();
    _timer = widget.isLive ? Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _dateTime = _dateTime?.add(Duration(seconds: 1));
      if(mounted) {
        setState(() {});
      }
    }) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.decoration,
      child: CustomPaint(
        child: widget.child,
        painter: AnalogClockPainter(_dateTime ?? DateTime.now(),
          dialPlateColor: widget.dialPlateColor,
          borderColor: widget.borderColor,
          hourHandColor: widget.hourHandColor,
          minuteHandColor: widget.minuteHandColor,
          secondHandColor: widget.secondHandColor,
          tickColor: widget.tickColor,
          numberColor: widget.numberColor,
          centerPointColor: widget.centerPointColor,
          showBorder: widget.showBorder,
          showTicks: widget.showTicks,
          showMinuteHand: widget.showMinuteHand,
          showSecondHand: widget.showSecondHand,
          showNumber: widget.showNumber,
          hourNumbers: widget.hourNumbers,
          borderWidth: widget.borderWidth,
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