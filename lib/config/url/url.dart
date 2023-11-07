// ignore_for_file: constant_identifier_names, non_constant_identifier_names, avoid_print, depend_on_referenced_packages

import 'package:cubetiq_attendance_app/config/url/base_url.dart';

class APIURL {
  static String? _baseUrl;
  static String? _metaDataProfile = 'kotluy2';

  static String get BASEURL {
    _baseUrl ??= BASEAPIURL.BASEURL;
    return _baseUrl!;
  }

  static setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  static setMetaDataProfile(String? profile) {
    _metaDataProfile = profile ?? 'kotluy2';
  }

  static get getBaseUrl {
    return _baseUrl;
  }

  static get getMetaDataProfile {
    return _metaDataProfile;
  }

  static final APIURL _instance = APIURL._internal();

  factory APIURL() {
    return _instance;
  }

  APIURL._internal();

  String get metaData => "$BASEURL/app/$_metaDataProfile/metadata.json";
  String get origin => "$BASEURL/front/graphql";
  String get originHealth => "$BASEURL/front/health";
  String get devOrigin => "$BASEURL/admin/graphql";
  String get getReport => "$BASEURL/front/transaction";
}
