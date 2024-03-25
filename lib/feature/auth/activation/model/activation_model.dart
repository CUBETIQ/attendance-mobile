class ActivateModel {
  String? deviceId;
  String? activationCode;
  DeviceInfoModel? deviceInfo;

  ActivateModel({
    this.deviceId,
    this.activationCode,
    this.deviceInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'activationCode': activationCode,
      'deviceInfo': deviceInfo?.toJson(),
    };
  }
}

class DeviceInfoModel {
  String? deviceName;
  String? version;

  DeviceInfoModel({
    this.deviceName,
    this.version,
  });

  Map<String, dynamic> toJson() {
    return {
      'deviceName': deviceName,
      'version': version,
    };
  }
}
