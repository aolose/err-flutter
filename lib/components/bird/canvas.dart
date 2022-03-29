import 'package:flutter/material.dart';

typedef _DrawFunc = Function(Canvas canvas, Size size);

class CustomCanvas extends StatelessWidget {
  final double width;
  final _DrawFunc draw;
  final double height;

  const CustomCanvas(
      {Key? key, required this.width, required this.draw, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
          painter: _Painter()..draw = draw,
        ));
  }
}

class _Painter extends CustomPainter {
  late _DrawFunc draw;

  @override
  void paint(Canvas canvas, Size size) {
    draw(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
