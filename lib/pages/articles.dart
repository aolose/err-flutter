import 'package:flutter/material.dart';
import '/components/article/item.dart';
import '/model/api.dart';

import '../model/article.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticleListState();
}

class _ArticleListState extends State {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  int page = 0;
  List<ListArticle> items = [];

  Future load() async {
    _refreshKey.currentState?.show();
    page = reload ? 1 : page + 1;
    var res = await ApiCli('arts').call({'page': page, 'count': 8});
    if (res.ok) {
      Map<String, dynamic> data = res.body;
      setState(() {
        if (reload) {
          items.clear();
        }
        if (data.containsKey('ls')) {
          for (var item in (data['ls'] as List<dynamic>)) {
            var a = ListArticle().fromJSON(item);
            int l = a.content.length;
            if (l > 128) a.content = '${a.content.substring(0, 128)}...';
            items.add(a);
          }
        }
      });
    }
  }
  var reload  =true;
  final scrollCtrl = ScrollController();

  @override
  void initState() {
    load();
    super.initState();
    scrollCtrl.addListener(() {
      var f = scrollCtrl.offset;
      if(scrollCtrl.position.atEdge){
        reload = f<10;
        if(!reload)load();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refreshKey,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: ListView(
            controller: scrollCtrl,
            children: List<ArtItem>.generate(
                items.length, (index) => ArtItem(items[index],key: Key('$index artItem'),))),
        onRefresh: () async {
          await load();
          print(111);
          return Future.delayed(const Duration(seconds: 3));
        });
  }
}
