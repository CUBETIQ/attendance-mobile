import 'package:timesync/core/repositories/base_model.dart';

class ActivationModel extends BaseModel<ActivationModel> {
  final String? deviceHash;
  final String? organizationId;

  ActivationModel({
    this.deviceHash,
    this.organizationId,
  });

  @override
  ActivationModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ActivationModel();
    }
    return ActivationModel(
      deviceHash: json['deviceHash'],
      organizationId: json['organizationId'],
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
      "deviceHash": deviceHash,
      "organizationId": organizationId,
    };
  }
}
