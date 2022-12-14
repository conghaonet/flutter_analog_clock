import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

import 'analog_clock_listener.dart';
import 'analog_clock_util.dart';

class DialPainter extends CustomPainter {
  final AnalogClockListener listener;
  final Color? dialColor;
  final Color? dialBorderColor;
  final double dialBorderWidthFactor;
  final Color? markingColor;
  final double markingRadiusFactor;
  final double markingWidthFactor;
  final List<String>? hourNumbers;
  final Color? hourNumberColor;
  final double hourNumberSizeFactor;
  final double hourNumberRadiusFactor;

  const DialPainter({
    required this.listener,
    this.dialColor,
    this.dialBorderColor,
    required this.dialBorderWidthFactor,
    this.markingColor,
    required this.markingRadiusFactor,
    required this.markingWidthFactor,
    this.hourNumbers,
    this.hourNumberColor,
    required this.hourNumberSizeFactor,
    required this.hourNumberRadiusFactor,
  }) : super(repaint: listener);

  @override
  void paint(Canvas canvas, Size size) {
    double clockRadius = math.min(size.width, size.height) / 2;
    double dialBorderWidth = clockRadius * dialBorderWidthFactor;
    listener.dialRadius = clockRadius - dialBorderWidth;
    // translate to center of clock
    canvas.translate(size.width / 2, size.height / 2);

    // draw dial
    if(dialColor != null && dialColor != Colors.transparent) {
      canvas.drawCircle(
        Offset.zero,
        clockRadius - dialBorderWidth,
        Paint()
          ..isAntiAlias = true
          ..color = dialColor!
          ..style = PaintingStyle.fill,
      );
    }

    // draw border
    if(dialBorderWidth > 0) {
      canvas.drawCircle(
        Offset.zero,
        clockRadius - dialBorderWidth / 2,
        Paint()
          ..isAntiAlias = true
          ..color = dialBorderColor ?? Colors.transparent
          ..style = PaintingStyle.stroke
          ..strokeWidth = dialBorderWidth,
      );
    }
    final hourNumberRadius = _drawMarkings(canvas, clockRadius - dialBorderWidth) * 0.85;
    _drawHourNumber(canvas, hourNumberRadius * hourNumberRadiusFactor);
    listener.hourNumberRadius = hourNumberRadius;
  }

  double _drawMarkings(final Canvas canvas, final double radius) {
    if(markingColor == null || markingColor == Colors.transparent
        || markingRadiusFactor <= 0.0 || markingWidthFactor <= 0.0) {
      return radius;
    }
    final double markingRadius = radius * 0.95 * markingRadiusFactor;
    listener.markingRadius = markingRadius;
    double smallMarkingWidth = (radius - markingRadius) / 1.5 * markingWidthFactor;
    if(smallMarkingWidth/2 + markingRadius > radius) {
      smallMarkingWidth = (radius - markingRadius) * 2;
    }
    double bigMarkingWidth = (radius - markingRadius) / 1 * markingWidthFactor;
    if(bigMarkingWidth/2 + markingRadius > radius) {
      bigMarkingWidth = (radius - markingRadius) * 2;
    }
    listener.bigMarkingWidth = bigMarkingWidth;

    final List<Offset> smallMarkings = [];
    final List<Offset> bigMarkings = [];
    for (var i = 0; i < 60; i++) {
      double _angle = i * 6.0;
      if (i % 5 != 0) {
        double x = math.cos(AnalogClockUtil.getRadians(_angle)) * markingRadius;
        double y = math.sin(AnalogClockUtil.getRadians(_angle)) * markingRadius;
        smallMarkings.add(Offset(x, y));
      } else {
        double x = math.cos(AnalogClockUtil.getRadians(_angle)) * markingRadius;
        double y = math.sin(AnalogClockUtil.getRadians(_angle)) * markingRadius;
        bigMarkings.add(Offset(x, y));
      }
    }
    Paint smallMarkingPaint = Paint()
      ..isAntiAlias = true
      ..color = this.markingColor!
      ..strokeWidth = smallMarkingWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, smallMarkings, smallMarkingPaint);
    Paint bigMarkingPaint = Paint()
      ..isAntiAlias = true
      ..color = this.markingColor!
      ..strokeWidth = bigMarkingWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, bigMarkings, bigMarkingPaint);
    return markingRadius - bigMarkingWidth/2;
  }

  /// draw hour number (1 - 12)
  void _drawHourNumber(final Canvas canvas, final double radius) {
    double maxHourNumberSide = 0;
    if(hourNumberColor == null || hourNumberColor == Colors.transparent
        || hourNumbers == null || hourNumbers!.isEmpty
        || hourNumberSizeFactor <= 0.0 || hourNumberRadiusFactor <= 0.0) {
      return;
    }
    double fontSize = radius/4 * hourNumberSizeFactor;
    for(int i=0; i<hourNumbers!.length; i++) {
      int hourNumberIndex = i + 2;
      if(hourNumberIndex >= hourNumbers!.length) hourNumberIndex -= hourNumbers!.length;
      final textPainter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: hourNumbers![hourNumberIndex],
          style: TextStyle(fontSize: fontSize, color: this.hourNumberColor),
        ),
      )..layout();
      double maxSize = math.max(textPainter.height, textPainter.width);
      if (maxSize > maxHourNumberSide) maxHourNumberSide = maxSize;

      double angle = i * 30.0;
      double hourNumberX = math.cos(AnalogClockUtil.getRadians(angle)) * radius;
      double hourNumberY = math.sin(AnalogClockUtil.getRadians(angle)) * radius;
      canvas.save();
      canvas.translate(hourNumberX, hourNumberY);
      textPainter.paint(canvas, Offset(-textPainter.width/2, -textPainter.height/2));
      canvas.restore();
    }
    listener.maxHourNumberSide = maxHourNumberSide;
  }

  @override
  bool shouldRepaint(covariant DialPainter oldDelegate) {
    return false;
  }

}