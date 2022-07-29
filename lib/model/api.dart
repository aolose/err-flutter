import 'dart:convert' as convert;
import '/api/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiData {
  String url = '';
  dynamic params;
  Map<String, String>? headers;
  dynamic body;
  bool ok = false;
  bool pending = true;
  dynamic error;

  ApiData(this.url, {this.params, this.headers});
}

typedef ApiHook = Function(ApiData);

class ApiCfg {
  int cacheTime;
  int method;
  String url = '';
  ApiHook? before;
  ApiHook? after;
  ApiHook? done;
  ApiHook? fail;

  ApiCfg(this.url,
      {this.method = 0,
      this.cacheTime = 0,
      this.before,
      this.after,
      this.done,
      this.fail});
}

typedef ApiCfgMap = Map<String, ApiCfg>;

class ApiCache {
  static final Map<String, List> _cache = {};

  static _syncLocal() {
    //todo save cache to local
  }

  static ApiData? get(String key, {ignoreTime}) {
    var c = _cache[key];
    if (c == null || (!ignoreTime && c[0] > DateTime.now())) {
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
  late ApiCfg _cfg;

  ApiCli(this.name) {
    _cfg = apiConfig[name]!;
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

  ApiData? getOldCache() {
    // todo
  }

  Future<ApiData> call(params, [ApiHook? done, ApiHook? fail]) async {
    var key = _generateCacheKey(params);
    var che = ApiCache.get(key);

    err(ApiData r) {
      if (fail != null) {
        fail(r);
        if (_cfg.fail != null) _cfg.fail!(r);
      }
      return r;
    }

    ok(ApiData r) {
      if (done != null) {
        done(r);
        if (_cfg.done != null) _cfg.done!(r);
      }
      return r;
    }

    if (che != null) {
      return ok(che);
    } else {
      String url = baseApi + _cfg.url;
      Map<String, String>? header = {'origin': 'https://www.err.name'};
      ApiData obj = ApiData(url, params: params);
      if (_cfg.before != null) _cfg.before!(obj);
      url = obj.url;
      params = obj.params;
      header = obj.headers;
      Response resp = http.Response('', 200);
      switch (_cfg.method) {
        case 0:
          if(params is String){
            url += '?$params';
          }else if(params is Map) {
            url+='?';
            params.forEach((key, value) {
              url+='$key=$value&';
            });
            url=url.substring(0,url.length-1);
          }
          resp = await http.get(Uri.parse(url));
          break;
        case 1:
          resp = await http.post(Uri.parse(url), headers: header, body: params);
          break;
      }
      obj.pending=false;
      var code = resp.statusCode;
      dynamic body;
      if (resp.body.isNotEmpty) {
        body = convert.jsonDecode(resp.body);
      }
      if (_cfg.after != null) _cfg.after!(obj);
      if (code >= 200) {
        if (code >= 400) {
          obj.error = body;
          return err(obj);
        }
        if (code < 300) {
          obj.ok = true;
          obj.body = body;
          return ok(obj);
        }
      }
      // todo
      return ok(obj);
    }
  }
}
