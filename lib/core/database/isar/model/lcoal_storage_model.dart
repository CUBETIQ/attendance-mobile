class LocalStorageModel {
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

  LocalStorageModel({
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
  });
}
