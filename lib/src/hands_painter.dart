import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'analog_clock_listener.dart';
import 'analog_clock_util.dart';

class HandPainter extends CustomPainter {
  final AnalogClockListener listener;
  final DateTime dateTime;
  final Color? hourHandColor;
  final Color? minuteHandColor;
  final Color? secondHandColor;
  final Color? centerPointColor;
  final double hourHandWidthFactor;
  final double minuteHandWidthFactor;
  final double secondHandWidthFactor;
  final double hourHandLengthFactor;
  final double minuteHandLengthFactor;
  final double secondHandLengthFactor;
  final double centerPointWidthFactor;
  const HandPainter({
    required this.listener,
    required this.dateTime,
    this.hourHandColor,
    this.minuteHandColor,
    this.secondHandColor,
    this.centerPointColor,
    required this.hourHandWidthFactor,
    required this.minuteHandWidthFactor,
    required this.secondHandWidthFactor,
    required this.hourHandLengthFactor,
    required this.minuteHandLengthFactor,
    required this.secondHandLengthFactor,
    required this.centerPointWidthFactor,
  }) : super(repaint: listener);

  @override
  void paint(Canvas canvas, Size size) {
    // translate to center of clock
    canvas.translate(size.width / 2, size.height / 2);

    if(hourHandLengthFactor > 0.0 && hourHandWidthFactor > 0.0
        && hourHandColor != null && hourHandColor != Colors.transparent) {
      double hourRadius = (listener.hourNumberRadius - listener.maxHourNumberSide/1.5) * hourHandLengthFactor;
      if(listener.maxHourNumberSide <= 0.0) {
        hourRadius = listener.hourNumberRadius * 0.75 * hourHandLengthFactor;
      }
      _drawHourHand(
        canvas,
        hourRadius,
        listener.dialRadius * 0.05 * hourHandWidthFactor,
      );
    }
    if(minuteHandLengthFactor > 0.0 && minuteHandWidthFactor > 0.0
        && minuteHandColor != null && minuteHandColor != Colors.transparent) {
      _drawMinuteHand(
        canvas,
        listener.hourNumberRadius * minuteHandLengthFactor,
        listener.dialRadius * 0.02 * minuteHandWidthFactor,
      );
    }
    if(secondHandLengthFactor > 0.0 && secondHandWidthFactor > 0.0
        && secondHandColor != null && secondHandColor != Colors.transparent) {
      double secondRadius = listener.markingRadius * secondHandLengthFactor;
      if(secondRadius == 0) {
        secondRadius = listener.dialRadius * 0.95 * secondHandLengthFactor;
      }
      _drawSecondHand(
        canvas,
        secondRadius,
        listener.dialRadius * 0.01 * secondHandWidthFactor,
      );
    }

    //draw center point
    if(centerPointColor != null && centerPointColor != Colors.transparent
        && centerPointWidthFactor > 0.0) {
      Paint centerPointPaint = Paint()
        ..strokeWidth = listener.dialRadius * 0.08 * centerPointWidthFactor
        ..strokeCap = StrokeCap.round
        ..color = this.centerPointColor!;
      canvas.drawPoints(PointMode.points, [Offset.zero], centerPointPaint);
    }
  }

  void _drawHourHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = dateTime.hour % 12 + dateTime.minute / 60.0 - 3;
    Offset handOffset = Offset(
        math.cos(AnalogClockUtil.getRadians(angle * 30)) * radius,
        math.sin(AnalogClockUtil.getRadians(angle * 30)) * radius
    );
    final hourHandPaint = Paint()
      ..color = this.hourHandColor ?? Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset.zero, handOffset, hourHandPaint);
  }

  /// draw minute hand
  void _drawMinuteHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = dateTime.minute - 15.0;
    Offset handOffset = Offset(
        math.cos(AnalogClockUtil.getRadians(angle * 6.0)) * radius,
        math.sin(AnalogClockUtil.getRadians(angle * 6.0)) * radius
    );
    final hourHandPaint = Paint()
      ..color = this.minuteHandColor ?? Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset.zero, handOffset, hourHandPaint);
  }

  /// draw second hand
  void _drawSecondHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = dateTime.second - 15.0;
    Offset handOffset = Offset(
        math.cos(AnalogClockUtil.getRadians(angle * 6.0)) * radius,
        math.sin(AnalogClockUtil.getRadians(angle * 6.0)) * radius
    );
    final hourHandPaint = Paint()
      ..color = this.secondHandColor ?? Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset.zero, handOffset, hourHandPaint);
  }

  @override
  bool shouldRepaint(covariant HandPainter oldDelegate) {
    return oldDelegate.dateTime != dateTime;
  }
}