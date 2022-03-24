import 'package:flutter/widgets.dart';

class ArtItem extends StatelessWidget{
  final String text;
  const ArtItem(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Text('Art Item $text');
  }
}