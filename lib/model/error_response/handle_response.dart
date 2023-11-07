class HandleModel {
  final String? message;
  final int? status;
  BodyModel? body;

  HandleModel({this.message, this.status, this.body});

  HandleModel fromMap(Map<String, dynamic> map) {
    return HandleModel(
      message: map['message'],
      body: BodyModel().fromMap(map['body']),
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'body': body?.toMap(),
      'status': status,
    };
  }
}

class BodyModel {
  final String? message;
  final String? mobileKey;
  final Map? variable;

  BodyModel({this.message, this.mobileKey, this.variable});

  BodyModel fromMap(Map<String, dynamic> map) {
    return BodyModel(
        message: map['message'],
        mobileKey: map['mobileKey'],
        variable: map['variable']);
  }

  Map<String, String> get getVariable =>
      variable?.map((key, value) => MapEntry(key, value.toString())) ?? {};

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'mobileKey': mobileKey,
      'variable': variable,
    };
  }
}
