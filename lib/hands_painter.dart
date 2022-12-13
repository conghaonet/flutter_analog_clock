import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'flutter_analog_clock.dart';

class HandPainter extends CustomPainter {
  final AnalogClockListener listener;
  final DateTime dateTime;
  final Color? hourHandColor;
  final Color? minuteHandColor;
  final Color? secondHandColor;
  final double hourHandWidthFactor;
  final double minuteHandWidthFactor;
  final double secondHandWidthFactor;
  final double hourHandLengthFactor;
  final double minuteHandLengthFactor;
  final double secondHandLengthFactor;
  const HandPainter({
    required this.listener,
    required this.dateTime,
    this.hourHandColor,
    this.minuteHandColor,
    this.secondHandColor,
    this.hourHandWidthFactor = 1.0,
    this.minuteHandWidthFactor = 1.0,
    this.secondHandWidthFactor = 1.0,
    this.hourHandLengthFactor = 1.0,
    this.minuteHandLengthFactor = 1.0,
    this.secondHandLengthFactor = 1.0,
  }) : super(repaint: listener);

  @override
  void paint(Canvas canvas, Size size) {
    // translate to center of clock
    canvas.translate(size.width / 2, size.height / 2);

    if(hourHandLengthFactor > 0 && hourHandWidthFactor > 0) {
      _drawHourHand(
        canvas,
        (listener.hourNumberRadius - listener.maxHourNumberSide/2) * hourHandLengthFactor,
        listener.dialRadius * 0.05 * hourHandWidthFactor,
      );
    }
    if(minuteHandLengthFactor > 0 && minuteHandWidthFactor > 0) {
      _drawMinuteHand(
        canvas,
        listener.hourNumberRadius * minuteHandLengthFactor,
        listener.dialRadius * 0.02 * minuteHandWidthFactor,
      );
    }
    if(secondHandLengthFactor > 0 && secondHandWidthFactor > 0) {
      _drawSecondHand(
        canvas,
        listener.markingRadius * secondHandLengthFactor,
        listener.dialRadius * 0.01 * secondHandWidthFactor,
      );
    }
  }

  void _drawHourHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = dateTime.hour % 12 + dateTime.minute / 60.0 - 3;
    Offset handOffset = Offset(
        math.cos(getRadians(angle * 30)) * radius,
        math.sin(getRadians(angle * 30)) * radius
    );
    final hourHandPaint = Paint()
      ..color = this.hourHandColor ?? Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  /// draw minute hand
  void _drawMinuteHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = dateTime.minute - 15.0;
    Offset handOffset = Offset(
        math.cos(getRadians(angle * 6.0)) * radius,
        math.sin(getRadians(angle * 6.0)) * radius
    );
    final hourHandPaint = Paint()
      ..color = this.minuteHandColor ?? Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  /// draw second hand
  void _drawSecondHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = dateTime.second - 15.0;
    Offset handOffset = Offset(
        math.cos(getRadians(angle * 6.0)) * radius,
        math.sin(getRadians(angle * 6.0)) * radius
    );
    final hourHandPaint = Paint()
      ..color = this.secondHandColor ?? Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  @override
  bool shouldRepaint(covariant HandPainter oldDelegate) {
    return oldDelegate.listener.hourNumberRadius != listener.hourNumberRadius || oldDelegate.dateTime != dateTime;
  }
  static double getRadians(double angle) {
    return angle * math.pi / 180;
  }
}