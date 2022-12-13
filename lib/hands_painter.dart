import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'flutter_analog_clock.dart';

class HandPainter extends CustomPainter {
  final AnalogClockListener listener;
  final DateTime dateTime;
  final Color? hourHandColor;
  final Color? minuteHandColor;
  final Color? secondHandColor;
  const HandPainter({
    required this.listener,
    required this.dateTime,
    this.hourHandColor,
    this.minuteHandColor,
    this.secondHandColor,
  }) : super(repaint: listener);

  @override
  void paint(Canvas canvas, Size size) {
    // translate to center of clock
    canvas.translate(size.width / 2, size.height / 2);

    _drawHourHand(canvas, listener.hourNumberRadius - listener.maxHourNumberSide/2, listener.dialRadius * 0.05);
    _drawMinuteHand(canvas, listener.hourNumberRadius, listener.dialRadius * 0.02);
    _drawSecondHand(canvas, listener.markingRadius, listener.dialRadius * 0.01);
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