import 'dart:math';
import 'package:flutter/material.dart';
import 'canvas.dart';

class Mouse extends StatelessWidget {
  final double width;

  const Mouse({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      origin: Offset(width, width / 2),
      angle: pi / 180 * 20,
      child: CustomCanvas(
        width: width,
        draw: (Canvas canvas, Size size) {
          double w = size.width;
          double h = size.height / 2;
          double h0 = h / 2;
          Paint paint = Paint()
            ..color = const Color(0xff131b2c)
            ..style = PaintingStyle.fill;
          Path path = Path()
            ..moveTo(w, h - h0)
            ..lineTo(w, h + h0)
            ..lineTo(0, h)
            ..close();
          canvas.drawPath(path, paint);
        },
        height: width * 0.7,
      ),
    );
  }
}
