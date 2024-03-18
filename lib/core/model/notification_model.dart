class NotificationPayloadModel {
  final PayloadModel? payload;

  NotificationPayloadModel({required this.payload});

  factory NotificationPayloadModel.fromJson(Map<String, dynamic> json) {
    return NotificationPayloadModel(
      payload: PayloadModel.fromJson(json['payload']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payload': payload?.toJson(),
    };
  }
}

class PayloadModel {
  final String? type;
  final PayloadDataModel? data;

  PayloadModel({required this.type, required this.data});

  factory PayloadModel.fromJson(Map<String, dynamic> json) {
    return PayloadModel(
      type: json['type'],
      data: PayloadDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'data': data?.toJson(),
    };
  }
}

class PayloadDataModel {
  final String? subtype;
  final Map<String, dynamic>? prop;

  PayloadDataModel({required this.subtype, required this.prop});

  factory PayloadDataModel.fromJson(Map<String, dynamic> json) {
    return PayloadDataModel(
      subtype: json['subtype'],
      prop: json['prop'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtype': subtype,
      'prop': prop,
    };
  }
}
