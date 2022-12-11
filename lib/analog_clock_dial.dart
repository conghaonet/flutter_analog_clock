import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class AnalogClockDial extends SingleChildRenderObjectWidget {
  final Color? dialColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderWidthFactor;
  final Color? markingColor;
  final double markingRadiusScale;
  final double markingWidthScale;
  const AnalogClockDial({
    super.key,
    super.child,
    this.dialColor,
    this.borderColor,
    this.borderWidth,
    this.borderWidthFactor,
    this.markingColor,
    this.markingRadiusScale = 0.95,
    this.markingWidthScale = 1.0,
  });

  @override
  _DialRender createRenderObject(BuildContext context) {
    return _DialRender(
      dialColor: this.dialColor,
      borderColor: this.borderColor,
      borderWidth: this.borderWidth,
      borderWidthFactor: this.borderWidthFactor,
      markingColor: this.markingColor,
      markingRadiusScale: this.markingRadiusScale,
      markingWidthScale: this.markingWidthScale,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _DialRender renderObject) {
    renderObject
      ..dialColor = this.dialColor
      ..borderColor = this.borderColor
      ..borderWidth = this.borderWidth
      ..borderWidthFactor = this.borderWidthFactor
      ..markingColor = this.markingColor
      ..markingRadiusScale = this.markingRadiusScale
      ..markingWidthScale = this.markingWidthScale;
  }
}

class _DialRender extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  Color? _dialColor;
  Color? get dialColor => _dialColor;
  set dialColor(Color? value) {
    if(_dialColor == value) return;
    _dialColor = value;
    markNeedsPaint();
  }

  Color? _borderColor;
  Color? get borderColor => _borderColor;
  set borderColor(Color? value) {
    if(_borderColor == value) return;
    _borderColor = value;
    markNeedsPaint();
  }

  double? _borderWidth;
  double? get borderWidth => _borderWidth;
  set borderWidth(double? value) {
    if(_borderWidth == value) return;
    _borderWidth = value;
    markNeedsPaint();
  }

  double? _borderWidthFactor;
  double? get borderWidthFactor => _borderWidthFactor;
  set borderWidthFactor(double? value) {
    if(_borderWidthFactor == value) return;
    _borderWidthFactor = value;
  }

  Color? _markingColor;
  Color? get markingColor => _markingColor;
  set markingColor(Color? value) {
    if(_markingColor == value) return;
    _markingColor = value;
    markNeedsPaint();
  }

  double _markingRadiusScale;
  double get markingRadiusScale => _markingRadiusScale;
  set markingRadiusScale(double value) {
    if(_markingRadiusScale == value) return;
    _markingRadiusScale = value;
    markNeedsPaint();
  }

  double _markingWidthScale;
  double get markingWidthScale => _markingWidthScale;
  set markingWidthScale(double value) {
    if(_markingWidthScale == value) return;
    _markingWidthScale = value;
    markNeedsPaint();
  }

  _DialRender({
    Color? dialColor,
    Color? borderColor,
    double? borderWidth,
    double? borderWidthFactor,
    Color? markingColor,
    double markingRadiusScale = 0.95,
    double markingWidthScale = 1.0,
  }) :  _dialColor = dialColor,
        _borderColor = borderColor,
        _borderWidth = borderWidth,
        _borderWidthFactor = borderWidthFactor,
        _markingColor = markingColor,
        _markingRadiusScale = markingRadiusScale,
        _markingWidthScale = markingWidthScale;

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    if(constraints.biggest.isFinite) {
      size = constraints.biggest;
    } else if(constraints.biggest.isInfinite) {
      double minSide = math.min(constraints.biggest.width, constraints.biggest.height);
      size = Size(minSide, minSide);
    } else {
      size = Size.zero;
    }
  }

  @override
  void performLayout() {
    BoxConstraints childConstraints = constraints;
    if(constraints.biggest.isInfinite) {
      childConstraints = constraints.copyWith(maxWidth: size.width, maxHeight: size.height);
    }
    child?.layout(childConstraints, parentUsesSize: false);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return child?.hitTest(result, position: position) == true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    double radius = math.min(size.width, size.height) / 2;
    double confirmedBorderWidth = _borderWidth ?? 0.0;
    if(_borderWidthFactor != null) {
      confirmedBorderWidth = radius * _borderWidthFactor!;
    }

    Offset center = Offset(offset.dx + size.width/2, offset.dy + size.height / 2);
    context.canvas.translate(center.dx, center.dy);
    if(_dialColor != null && _dialColor != Colors.transparent) {
      context.canvas.drawCircle(
        Offset.zero,
        radius - confirmedBorderWidth,
        Paint()..isAntiAlias = true..color = _dialColor!,
      );
    }
    if(confirmedBorderWidth > 0) {
      context.canvas.drawCircle(
        Offset.zero,
        radius - confirmedBorderWidth / 2,
        Paint()
          ..isAntiAlias = true
          ..color = _borderColor ?? Colors.transparent
          ..style = PaintingStyle.stroke
          ..strokeWidth = confirmedBorderWidth,
      );
    }

    _paintMarkings(context.canvas, radius - confirmedBorderWidth);

    context.canvas.restore();
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }

  void _paintMarkings(final Canvas canvas, final double radius) {
    if(_markingColor == null || _markingColor == Colors.transparent) return;

    final double markingRadius = radius * _markingRadiusScale;
    final double markingCircumference = 2 * markingRadius * math.pi;

    double smallMarkingWidth = markingCircumference / 200 * _markingWidthScale;
    if(smallMarkingWidth/2 + markingRadius > radius) {
      smallMarkingWidth = (radius - markingRadius) * 2;
    }

    double bigMarkingWidth = markingCircumference / 120 * _markingWidthScale;
    if(bigMarkingWidth/2 + markingRadius > radius) {
      bigMarkingWidth = (radius - markingRadius) * 2;
    }

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
      ..color = this._markingColor!
      ..strokeWidth = smallMarkingWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, smallMarkings, smallMarkingPaint);

    Paint bigMarkingPaint = Paint()
      ..isAntiAlias = true
      ..color = this._markingColor!
      ..strokeWidth = bigMarkingWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, bigMarkings, bigMarkingPaint);
  }

  static double getRadians(double angle) {
    return angle * math.pi / 180;
  }
}
