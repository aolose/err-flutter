import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bird extends AnimatedWidget {
  const Bird({Key? key, required AnimationController controller})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double parentW = constraints.maxWidth;
      double bodyW =parentW> 800 ? 200 : parentW / 4;
      return Center(
          child: Column(
        children: [
          Text('$parentW'),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Color(0xff000000), shape: BoxShape.circle),
            width: bodyW,
            height: bodyW,
          ),
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
