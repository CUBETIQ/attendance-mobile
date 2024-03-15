class EditPositionModel {
  final String? name;
  final String? description;
  final String? image;
  final String? departmentId;

  EditPositionModel({
    this.name,
    this.description,
    this.image,
    this.departmentId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "image": image,
      "departmentId": departmentId,
    };
  }
}
