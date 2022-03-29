import 'package:flutter/cupertino.dart';

import 'CustomCanvas.dart';

class BirdFoot extends StatelessWidget {
  final double height;

  const BirdFoot({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCanvas(
        height: height,
        width: height * 0.3,
        draw: (Canvas canvas, Size size) {
          double w = size.width / 2;
          double h = size.height;
          var start = Offset(w, 0);
          var end = Offset(w, h);
          var fg0 = start.translate(0, h * 0.83);
          var fg1 = fg0.translate(-w * .7, h * 0.13);
          var fg2 = fg1.translate(w * 1.4, 0);
          var paint = Paint()
            ..strokeWidth = 1.4
            ..color = const Color(0x55000000);
          canvas
            ..drawLine(start, end, paint)
            ..drawLine(fg0, fg1, paint)
            ..drawLine(fg0, fg2, paint);
        });
  }
}

