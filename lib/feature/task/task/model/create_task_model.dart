class CreateTaskModel {
  final String? taskName;
  final String? taskDescription;
  final String? taskType;
  final int? startDate;
  final int? endDate;

  CreateTaskModel({
    this.taskName,
    this.taskDescription,
    this.taskType,
    this.startDate,
    this.endDate,
  });
}
