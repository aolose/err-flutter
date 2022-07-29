class Article {
  int id = 0;
  String title = '';
  String content = '';
  String tags = '';
  String desc = '';
  String banner = '';
  int updated = 0;
  int created = 0;

  Article();

  fromJSON(Map<String, dynamic> json){
    id = json['aid'];
    title = json['title'];
    content = json['pubCont'];
    tags = json['tags'];
    desc = json['desc'];
    updated = json['updated'];
    created = json['created'];
    banner = json['banner'];
  }
}

class ListArticle {
  String url = '';
  String title = '';
  String content = '';
  int updated = 0;
  String banner = '';

  ListArticle();

  ListArticle fromJSON(Map<String, dynamic> json) {
    url = json['slug'];
    title = json['title'];
    content = json['content'];
    updated = json['updated'];
    banner = json['banner'];
    return this;
  }
}
