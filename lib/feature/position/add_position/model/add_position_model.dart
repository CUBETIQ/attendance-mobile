class AddPositionModel {
  final String? name;
  final String? description;
  final String? image;
  final String? organizationId;

  AddPositionModel({
    this.name,
    this.description,
    this.image,
    this.organizationId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "image": image,
      "organizationId": organizationId,
    };
  }
}
