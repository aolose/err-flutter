import 'dart:math';

import 'package:flutter/material.dart';

import '../utils.dart';
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
      double v = _progress.value;
      double v1 = boosts(v, 10);
      double v2 = boosts(v, 2);
      Widget foot = Transform(
        transform: Matrix4.rotationZ(-0.3 - v2 * 0.6),
        origin: Offset(d * 0.075, 0),
        child: BirdFoot(
          height: d * 0.5,
        ),
      );
      return Container(
        margin: const EdgeInsets.all(50),
        child: Center(
          child: Transform.translate(
              offset: Offset((v - 0.5) * 20, sin(pi * v)),
              child: Transform.rotate(
                  angle: boosts(v, 2) / 4,
                  child: Circle(
                    d: d,
                    children: [
                      Positioned(
                        child: Mouse(width: d / 7),
                        right: d * 0.98,
                        top: d * .33,
                      ),
                      Positioned(
                        child: Circle(d: d / 20, color: 0xFFFFFFFF),
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
                        child: Transform(
                          child: Wing(width: d * 0.7),
                          origin: Offset(d * 0.7, 0),
                          transform: Matrix4.skewX(0.1 + v1 / 3.6),
                        ),
                        right: 0,
                        top: d / 2,
                      )
                    ],
                  ))),
        ),
      );
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
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);

  @override
  Widget build(BuildContext context) {
    return Bird(controller: _controller);
  }
}
