import 'package:get/get_navigation/src/routes/new_path_route.dart';
import 'package:timesync/constants/svg.dart';

class SvgUtil {
  static String getSvgByExtenion(String? extension) {
    if (extension == null) {
      return "";
    }

    final Map<String, String> svgMap = {
      'csv': SvgAssets.fileIconCsv,
      'doc': SvgAssets.fileIconDoc,
      'docx': SvgAssets.fileIconDoc,
      'epub': SvgAssets.fileIconEpub,
      'gif': SvgAssets.fileIconGif,
      'mp3': SvgAssets.fileIconMp3,
      'mp4': SvgAssets.fileIconMp4,
      'pdf': SvgAssets.fileIconPdf,
      'pptx': SvgAssets.fileIconPpt,
      'txt': SvgAssets.fileIconTxt,
      'xls': SvgAssets.fileIconXls,
      'heic': SvgAssets.fileIconHeic,
    };

    final entry = svgMap.entries
        .firstWhereOrNull((entry) => (extension).contains(entry.key));
    if (entry == null) {
      return "";
    }
    return entry.value;
  }
}
