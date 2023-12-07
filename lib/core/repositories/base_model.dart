abstract class BaseModel<T> {
  T fromJson(Map<String, dynamic>? json);

  Map<String, dynamic> toJson();

  List<T> fromListJson(List<dynamic>? listJson);

  @override
  String toString() => toJson().toString();
}
