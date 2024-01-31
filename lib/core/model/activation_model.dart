import 'package:timesync360/core/repositories/base_model.dart';

class ActivationModel extends BaseModel<ActivationModel> {
  final String? id;
  final String? organizationId;
  final String? activationCode;
  final List<String>? device;
  final int? limitActivation;

  ActivationModel({
    this.id,
    this.organizationId,
    this.activationCode,
    this.device,
    this.limitActivation,
  });

  @override
  ActivationModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ActivationModel();
    }
    return ActivationModel(
      id: json['id'],
      organizationId: json['organizationId'],
      activationCode: json['activationCode'],
      device: json['device'] != null
          ? List<String>.from(json['device'])
          : <String>[],
      limitActivation: json['limitActivation'],
    );
  }

  @override
  List<ActivationModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <ActivationModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "organizationId": organizationId,
      "activationCode": activationCode,
      "device": device,
      "limitActivation": limitActivation,
    };
  }
}
