import 'package:flutter/widgets.dart';

class ArtItem extends StatelessWidget {
  final String text;

  const ArtItem(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 40.0, color: Color(0xFFFFFFFF)),
      ),
      margin: const EdgeInsets.all(5.0 ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color.fromRGBO(99, 99, 99, 1.0)),
    );
  }
}
