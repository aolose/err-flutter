import 'dart:ui' as ui;

import 'package:err/components/bird/CustomCanvas.dart';
import 'package:flutter/material.dart';

class Wing extends StatelessWidget {
  final double width;

  const Wing({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCanvas(
        width: width,
        height: width,
        draw: (Canvas canvas, Size size) {
          Paint paint = Paint()
            ..style = PaintingStyle.fill
            ..shader = ui.Gradient.linear(
                Offset(0, width / 4),
                Offset(width, 0),
                [const Color(0xff3d7aa5), const Color(0xff424d67)]);
          Path path = Path()
            ..moveTo(0, 0)
            ..lineTo(width,0)
            ..lineTo(width, width)
            ..close();
          canvas.drawPath(path, paint);
        });
  }
}
