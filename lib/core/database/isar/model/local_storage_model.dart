class LocalStorageModel {
  String? userId;
  bool? isFirstTime;
  String? accessToken;
  bool? darkTheme;
  String? language;
  String? isRememberMe;
  String? username;
  String? refreshToken;
  bool? isActivated;
  String? organizationId;
  String? languageCode;
  String? theme;
  bool? isEnableNotification;
  String? userRole;
  bool? isDevMode;
  bool? confirmCheckIn;
  String? deviceHash;

  LocalStorageModel({
    this.userId,
    this.isFirstTime,
    this.accessToken,
    this.darkTheme,
    this.language,
    this.isRememberMe,
    this.username,
    this.refreshToken,
    this.isActivated,
    this.organizationId,
    this.languageCode,
    this.theme,
    this.isEnableNotification,
    this.userRole,
    this.isDevMode,
    this.confirmCheckIn,
    this.deviceHash,
  });
}
