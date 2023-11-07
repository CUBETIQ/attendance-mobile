import 'package:isar/isar.dart';

part 'storageConfig.g.dart';

@Collection()
class StorageConfigure {
  @Index(unique: true, replace: true)
  Id? id;
  String? token;
  String? language;
  String? rememberAccount;
  bool? darkTheme;
  bool? isAppOpened;
  int? userID;
  String? firstName;
  String? lastName;
  String? username;
  String? device;
  String? hash;
  String? bucketId;
  String? uploadUrl;
  String? uploadHash;
  String? baseUrl;
  String? metaDataProfile;
}
