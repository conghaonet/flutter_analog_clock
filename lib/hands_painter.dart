import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'flutter_analog_clock.dart';

class HandPainter extends CustomPainter {
  final AnalogClockListener listener;
  final DateTime dateTime;
  final double? borderWidth;
  final double? borderWidthFactor;
  final Color? hourHandColor;
  final Color? minuteHandColor;
  final Color? secondHandColor;
  const HandPainter({
    required this.listener,
    required this.dateTime,
    this.borderWidth,
    this.borderWidthFactor,
    this.hourHandColor,
    this.minuteHandColor,
    this.secondHandColor,
  }) : super(repaint: listener);

  @override
  void paint(Canvas canvas, Size size) {
    double clockRadius = math.min(size.width, size.height) / 2;
    double confirmedBorderWidth = borderWidth ?? 0.0;
    if(borderWidthFactor != null) {
      confirmedBorderWidth = clockRadius * borderWidthFactor!;
    }
    // translate to center of clock
    canvas.translate(size.width / 2, size.height / 2);

    double hourHandRadius = listener.hourTextRadius - listener.maxTextSize/2;
    double angle = dateTime.hour % 12 + dateTime.minute / 60.0 - 3;
    Offset handOffset = Offset(
        math.cos(getRadians(angle * 30)) * hourHandRadius,
        math.sin(getRadians(angle * 30)) * hourHandRadius
    );
    final hourHandPaint = Paint()
      ..color = this.hourHandColor ?? Colors.transparent
      ..strokeWidth = 8;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);

    _paintMinuteHand(canvas, listener.hourTextRadius, 4);
    _paintSecondHand(canvas, listener.markingRadius, 2);
  }

  /// draw minute hand
  void _paintMinuteHand(Canvas canvas, double radius, double strokeWidth) {
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
  void _paintSecondHand(Canvas canvas, double radius, double strokeWidth) {
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
    return oldDelegate.listener.hourTextRadius != listener.hourTextRadius || oldDelegate.dateTime != dateTime;
  }
  static double getRadians(double angle) {
    return angle * math.pi / 180;
  }
}