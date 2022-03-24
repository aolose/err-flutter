import 'package:flutter/material.dart';

import 'item.dart';

class ArtList extends StatelessWidget {
  const ArtList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      children: List.generate(100, (index) => Center(
        child: ArtItem('$index'),
      )),
    );
  }
}
