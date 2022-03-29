import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double d;
  final int? color;
  final List<Widget> children;

  const Circle(
      {Key? key, required this.d, this.color, this.children = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: d,
      height: d,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(color ?? 0xFF000000), shape: BoxShape.circle),
          ),
          ...children,
        ],
      ),
    );
  }
}
