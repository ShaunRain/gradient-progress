library gradient_progress;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GradientCircularProgressIndicator extends StatelessWidget {
  final double strokeWidth;
  final bool strokeRound;
  final double value;
  final Color backgroundColor;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final double radius;

  /// Constructor require progress [radius] & gradient color range [gradientColors]
  /// , option includes: circle width [strokeWidth], round support [strokeRound]
  /// , progress background [backgroundColor].
  ///
  /// set progress with [value], 0.0 to 1.0.
  GradientCircularProgressIndicator({
    this.strokeWidth = 10.0,
    this.strokeRound = false,
    @required this.radius,
    @required this.gradientColors,
    this.gradientStops,
    this.backgroundColor = Colors.transparent,
    this.value,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }

  @override
  Widget build(BuildContext context) {
    var _colors = gradientColors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }

    return Transform.rotate(
      angle: -pi / 2,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
            strokeWidth: strokeWidth,
            strokeRound: strokeRound,
            backgroundColor: backgroundColor,
            gradientColors: _colors,
            value: value,
            radius: radius),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter({
    this.strokeWidth,
    this.strokeRound,
    this.value,
    this.backgroundColor = Colors.transparent,
    this.gradientColors,
    this.gradientStops,
    this.total = 2 * pi,
    this.radius,
  });

  final double strokeWidth;
  final bool strokeRound;
  final double value;
  final Color backgroundColor;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final double total;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }

    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    double _offset = strokeWidth / 2;
    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    var paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    if (_value > 0) {
      paint.shader = SweepGradient(
              colors: gradientColors,
              startAngle: 0.0,
              endAngle: _value,
              stops: gradientStops)
          .createShader(rect);

      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
