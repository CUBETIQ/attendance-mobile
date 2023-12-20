class CreateTaskModel {
  final String? taskName;
  final String? taskDescription;
  final int? startDate;
  final int? endDate;
  final String? color;
  final String? icon;

  CreateTaskModel({
    this.taskName,
    this.taskDescription,
    this.startDate,
    this.endDate,
    this.color,
    this.icon,
  });
}
