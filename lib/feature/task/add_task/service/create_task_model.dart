class CreateTaskModel {
  final String? name;
  final String? description;
  final int? startDate;
  final int? endDate;
  final String? color;
  final String? icon;

  CreateTaskModel({
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.color,
    this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "startDate": startDate,
      "endDate": endDate,
      "color": color,
      "icon": icon,
    };
  }
}
