class CreateCategoryModel {
  final String? name;
  final String? description;
  final String? icon;
  final String? color;
  final String? type;
  final String? organizationId;

  CreateCategoryModel({
    this.name,
    this.description,
    this.icon,
    this.color,
    this.type,
    this.organizationId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "icon": icon,
      "color": color,
      "type": type,
      "organizationId": organizationId,
    };
  }
}
