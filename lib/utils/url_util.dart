import 'package:get/get.dart';

String urlRefactoring(String url, {String? lang}) {
  if (url.isEmpty) return '';

  Uri uri = Uri.parse(url);
  Map<String, String> queryParameters = Map.from(uri.queryParameters);

  String theme = Get.isDarkMode ? 'dark' : 'light';

  if (!queryParameters.containsKey('app')) {
    queryParameters['app'] = 'true';
  }

  if (!queryParameters.containsKey('lang')) {
    lang ??= Get.locale.toString().isNotEmpty ? Get.locale.toString() : 'en';
    queryParameters['lang'] = lang;
  }


  if (!queryParameters.containsKey('theme')) {
    queryParameters['theme'] = theme;
  }

  if (!queryParameters.containsKey('utm_source')) {
    queryParameters['utm_source'] = 'timesyncapp';
  }

  uri = uri.replace(queryParameters: queryParameters);
  return uri.toString();
}
