class AddDepartmentModel {
  final String? name;
  final String? description;
  final String? image;
  final String? organizationId;

  AddDepartmentModel({
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
