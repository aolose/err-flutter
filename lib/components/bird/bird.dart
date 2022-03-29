import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'foot.dart';
import 'wing.dart';
import 'circle.dart';
import 'mouse.dart';

class Bird extends AnimatedWidget {
  const Bird({Key? key, required AnimationController controller})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double parentW = constraints.maxWidth;
      double d = parentW > 800 ? 100 : parentW / 8;
      double left = d * 0.5 - d * 0.3 / 2;
      Widget foot = BirdFoot(
        height: d * 0.5,
      );

      return Center(
          child: Column(
        children: [
          Text('$parentW'),
          Circle(
            d: d,
            children: [
              Positioned(
                child: Mouse(width: d / 6),
                right: d * 0.98,
                top: d * .32,
              ),
              Positioned(
                child: const Circle(d: 6, color: 0xFFFFFFFF),
                top: d * 0.3,
                left: d * 0.16,
              ),
              Positioned(
                child: foot,
                top: d * 0.9,
                left: left,
              ),
              Positioned(child: foot, top: d * 0.9, right: left),
              Positioned(
                child: Wing(width: d * 0.7),
                right: 0,
                top: d / 2,
              )
            ],
          )
        ],
      ));
    });
  }
}

class AniBird extends StatefulWidget {
  const AniBird({Key? key}) : super(key: key);

  @override
  State<AniBird> createState() => _AniBirdState();
}

class _AniBirdState extends State<AniBird> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 5))
        ..repeat();

  @override
  Widget build(BuildContext context) {
    return Bird(controller: _controller);
  }
}
