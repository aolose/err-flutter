import 'package:flutter/material.dart';
import '/model/api.dart';

import '../model/article.dart';

class ArticlePage extends StatefulWidget {
  final String url;

  const ArticlePage(this.url, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticleState();
}

class _ArticleState extends State<ArticlePage> {
  bool loading = false;
  Article article = Article();

  Future load(url) async {
    var data = await ApiCli('art').call(url);
    var res = data.body;
    setState(() {
      article.fromJSON(res);
    });
  }

  @override
  void initState() {
    super.initState();
    load(widget.url);
  }

  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      key: key,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.blurBackground],
                background: const Image(
                    image: NetworkImage(
                        'https://www.err.name/_app/assets/1-2d324238.jpg'),
                    alignment: Alignment.topCenter,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover),
                title: Text(
                  article.title,
                  style: const TextStyle(shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 10.0,
                      color: Color.fromARGB(80, 0, 0, 0),
                    )
                  ], color: Colors.white),
                ),
              )),
          SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: SingleChildScrollView(
                primary: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  constraints: BoxConstraints(minHeight: size.height),
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    article.content,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 2,
                      decoration: TextDecoration.none,
                      color: Colors.white60,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
