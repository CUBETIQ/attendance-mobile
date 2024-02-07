class UpdateCategoryModel {
  final String? name;
  final String? description;
  final String? icon;
  final String? color;
  final String? type;

  UpdateCategoryModel({
    this.name,
    this.description,
    this.icon,
    this.color,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "icon": icon,
      "color": color,
      "type": type,
    };
  }
}
