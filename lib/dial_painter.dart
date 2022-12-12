import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

import 'flutter_analog_clock.dart';


class DialPainter extends CustomPainter {
  final AnalogClockListener listener;
  final Color? dialColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderWidthFactor;
  final Color? markingColor;
  final double markingRadiusScale;
  final double markingWidthScale;
  final List<String> hourNumbers;
  final Color? numberColor;
  const DialPainter({
    required this.listener,
    this.dialColor,
    this.borderColor,
    this.borderWidth,
    this.borderWidthFactor,
    this.markingColor,
    this.markingRadiusScale = 0.95,
    this.markingWidthScale = 1.0,
    this.hourNumbers = const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    this.numberColor
  }) : super(repaint: listener);
  @override
  void paint(Canvas canvas, Size size) {
    double clockRadius = math.min(size.width, size.height) / 2;
    double confirmedBorderWidth = borderWidth ?? 0.0;
    if(borderWidthFactor != null) {
      confirmedBorderWidth = clockRadius * borderWidthFactor!;
    }
    listener.dialRadius = clockRadius - confirmedBorderWidth;
    // translate to center of clock
    canvas.translate(size.width / 2, size.height / 2);

    // draw dial
    if(dialColor != null && dialColor != Colors.transparent) {
      canvas.drawCircle(
        Offset.zero,
        clockRadius - confirmedBorderWidth,
        Paint()
          ..isAntiAlias = true
          ..color = dialColor!
          ..style = PaintingStyle.fill,
      );
    }

    // draw border
    if(confirmedBorderWidth > 0) {
      canvas.drawCircle(
        Offset.zero,
        clockRadius - confirmedBorderWidth / 2,
        Paint()
          ..isAntiAlias = true
          ..color = borderColor ?? Colors.transparent
          ..style = PaintingStyle.stroke
          ..strokeWidth = confirmedBorderWidth,
      );
    }
    final hourTextRadius = _drawMarkings(canvas, clockRadius - confirmedBorderWidth) * 0.85;
    _drawHourText(canvas, hourTextRadius);
    listener.hourTextRadius = hourTextRadius;
  }

  double _drawMarkings(final Canvas canvas, final double radius) {
    if(markingColor == null || markingColor == Colors.transparent) {
      return radius;
    }
    final double markingRadius = radius * markingRadiusScale;
    listener.markingRadius = markingRadius;
    double smallMarkingWidth = (radius - markingRadius) / 1.5 * markingWidthScale;
    if(smallMarkingWidth/2 + markingRadius > radius) {
      smallMarkingWidth = (radius - markingRadius) * 2;
    }
    double bigMarkingWidth = (radius - markingRadius) / 1 * markingWidthScale;
    if(bigMarkingWidth/2 + markingRadius > radius) {
      bigMarkingWidth = (radius - markingRadius) * 2;
    }
    listener.bigMarkingWidth = bigMarkingWidth;

    final List<Offset> smallMarkings = [];
    final List<Offset> bigMarkings = [];
    for (var i = 0; i < 60; i++) {
      double _angle = i * 6.0;
      if (i % 5 != 0) {
        double x = math.cos(getRadians(_angle)) * markingRadius;
        double y = math.sin(getRadians(_angle)) * markingRadius;
        smallMarkings.add(Offset(x, y));
      } else {
        double x = math.cos(getRadians(_angle)) * markingRadius;
        double y = math.sin(getRadians(_angle)) * markingRadius;
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

  /// draw hour text (1 - 12)
  double _drawHourText(Canvas canvas, double radius) {
    double maxTextSide = 0;
    if(numberColor == null || numberColor == Colors.transparent) {
      return maxTextSide;
    }
    double fontSize = radius/4;
    for(int i=0; i<12; i++) {
      int hourIndex = i + 2;
      if(hourIndex >= 12) hourIndex -= 12;
      final textPainter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: hourNumbers[hourIndex],
          style: TextStyle(fontSize: fontSize, color: this.numberColor),
        ),
      )..layout();
      double maxSize = math.max(textPainter.height, textPainter.width);
      if (maxSize > maxTextSide) maxTextSide = maxSize;

      double angle = i * 30.0;
      double hourNumberX = math.cos(getRadians(angle)) * radius;
      double hourNumberY = math.sin(getRadians(angle)) * radius;
      canvas.save();
      canvas.translate(hourNumberX, hourNumberY);
      textPainter.paint(canvas, Offset(-textPainter.width/2, -textPainter.height/2));
      canvas.restore();
    }
    listener.maxTextSize = maxTextSide;
    return maxTextSide;
  }

  static double getRadians(double angle) {
    return angle * math.pi / 180;
  }

  @override
  bool shouldRepaint(covariant DialPainter oldDelegate) {
    return false;
  }

}
