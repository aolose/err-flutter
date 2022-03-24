import 'package:err/api/config.dart';
import 'dart:convert';

class Article {
  final int id;
  final String title;
  final String content;
  final String tags;
  final String desc;
  final int updated;
  final int created;

  Article(this.id, this.title, this.content, this.tags, this.desc, this.updated,
      this.created);

  Article.fromJSON(Map<String, dynamic> json)
      : id = json['aid'],
        title = json['title'],
        content = json['content'],
        tags = json['tags'],
        desc = json['desc'],
        updated = json['updated'],
        created = json['created'];
}

typedef ApiHook = Function(Map res);

class ApiOption {
  final int cacheTime;
  final int method;
  final String url;
  final ApiHook? before;
  final ApiHook? after;
  final ApiHook? done;
  final ApiHook? fail;

  ApiOption(this.url,
      [int? method,
      int? cacheTime,
      ApiHook? before,
      ApiHook? after,
      ApiHook? done,
      ApiHook? fail])
      : method = method!,
        cacheTime = cacheTime!,
        before = before!,
        after = after!,
        done = done!,
        fail = fail!;
}

typedef ApiCfg = Map<String, ApiOption>;

class ApiCache {
  static final Map<String, List> _cache = {};

  static _syncLocal() {
    //todo save cache to local
  }

  static Map? get(String key) {
    var c = _cache[key];
    if (c == null || c[0] > DateTime.now()) {
      if (_cache.remove(key) != null) {
        _syncLocal();
      }
      return null;
    } else {
      return c[1];
    }
  }

  static set(String key, int expire, Map data) {
    _cache[key] = [expire, data];
    _syncLocal();
  }
}

class ApiCli {
  late String name;
  late ApiOption? _cfg;

  ApiCli(this.name) {
    _cfg = apiConfig[name]!;
    assert(_cfg != null);
  }

  String _generateCacheKey(params) {
    var k = '';
    if (params is Map) {
      k = json.encode(params);
    } else {
      k = params!;
    }
    var a = 0;
    for (int i = 0; i < k.length; i++) {
      a += k.codeUnitAt(i);
    }
    return name + a.toRadixString(36);
  }

  Future call(params, [ApiHook? done, ApiHook? fail]) async {
    var key = _generateCacheKey(params);
    var che = ApiCache.get(key);
    ok(resp) {
      if (done!(resp) != null) {
        _cfg?.done!(resp);
      }
      return resp;
    }

    if (che != null) {
      return ok(che);
    } else {
      // todo request
    }
  }
}
