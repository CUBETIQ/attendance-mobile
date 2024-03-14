import 'package:isar/isar.dart';

part 'local_storage.g.dart';

@Collection()
class LocalStorage {
  @Index(unique: true, replace: true)
  Id? id;
  String? organizationId;
  bool? isActivated = false;
  bool? isFirstTime = true;
  bool? isEnableNotification;
  bool? isDevMode;
  bool? darkTheme;
  String? accessToken;
  String? refreshToken;
  String? language;
  String? isRememberMe;
  String? username;
  String? userId;
  String? theme;
  String? userRole;
}
