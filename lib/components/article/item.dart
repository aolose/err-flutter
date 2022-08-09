import 'package:flutter/material.dart';
import '/model/article.dart';
import '/pages/article.dart';

class ArtItem extends StatelessWidget {
  final ListArticle art;
  final int index;

  const ArtItem(this.art, {Key? key, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = [
      Colors.blue,
      Colors.blueGrey,
      Colors.indigo,
      Colors.amber,
      Colors.orangeAccent,
      Colors.teal,
      Colors.grey,
      Colors.lightGreen,
      Colors.pinkAccent,
      Colors.purpleAccent
    ][index % 10];
    var date = DateTime.fromMicrosecondsSinceEpoch(art.updated * 1000000);
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ArticlePage(art.url);
          }));
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 60,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(
                      color: color.withAlpha(90),
                      width: 1,
                      style: BorderStyle.solid,
                    )),
                child: Column(
                  children: [
                    Text(
                      '${date.year}',
                      style: TextStyle(
                          height: 1.6, fontSize: 11, color: Colors.white70),
                    ),
                    Expanded(
                        child: Container(
                      color: color.withAlpha(100),
                      child: Center(
                          child: Text(
                        '${date.day}',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    )),
                    Text(
                      '${date.month}',
                      style: TextStyle(
                          height: 1.4, fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: color.withAlpha(10),
                        offset: Offset(0, 4),
                        blurRadius: 4)
                  ],
                  color: color.withAlpha(50),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      art.title,
                      style: TextStyle(
                          height: 2, fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      art.content,
                      style: TextStyle(
                          height: 2, fontSize: 13, color: Colors.white60),
                    )
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}
