
import '../model/api.dart';

const String baseApi = 'https://api.err.name/';

final ApiCfgMap apiConfig = {
  'arts': ApiCfg('posts', before: (ApiData d) {
    var data = d.params as Map;
    d.url = '${d.url}/${data.remove('page')}';
  }),
  'art': ApiCfg(
    'post',
    before: (ApiData d) {
      d.url = '${d.url}/${d.params}';
      d.params = null;
    },
  ),
};
