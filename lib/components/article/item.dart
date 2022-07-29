import 'package:flutter/material.dart';
import '/model/article.dart';
import '/pages/article.dart';

class ArtItem extends StatelessWidget {
  final ListArticle art;

  const ArtItem(this.art, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ArticlePage(art.url);
        }));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0x33333300),width: 1)
        ),
        child: Column(children: [
          Text(art.title),
          Text(art.content)
        ],),
      ),
    );
  }
}
