import 'package:isar/isar.dart';

part 'local_storage.g.dart';

@Collection()
class LocalStorage {
  @Index(unique: true, replace: true)
  Id? id;
  String? organizationId;
  bool? isActivated = false;
  String? accessToken;
  String? refreshToken;
  String? language;
  bool? darkTheme;
  bool? isFirstTime = true;
  String? isRememberMe;
  String? username;
  String? userId;
  String? theme;
  bool? isEnableNotification;
}
