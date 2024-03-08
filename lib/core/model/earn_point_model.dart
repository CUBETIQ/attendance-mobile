import 'package:timesync/core/repositories/base_model.dart';

class EarnPointModel extends BaseModel<EarnPointModel> {
  final String? id;
  final String? userid;
  final String? organizationId;
  final int? points;

  EarnPointModel({
    this.id,
    this.userid,
    this.organizationId,
    this.points,
  });

  @override
  EarnPointModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return EarnPointModel();
    }
    return EarnPointModel(
      id: json['id'],
      userid: json['userid'],
      organizationId: json['organizationId'],
      points: json['points'],
    );
  }

  @override
  List<EarnPointModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <EarnPointModel>[];
    }
    return listJson.map((data) => fromJson(data)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userid,
      'organizationId': organizationId,
      'points': points,
    };
  }
}
