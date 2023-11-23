import 'package:isar/isar.dart';

part 'local_storage.g.dart';

@Collection()
class LocalStorage {
  @Index(unique: true, replace: true)
  Id? id;
  String? accessToken;
  String? language;
  bool? darkTheme;
  bool? isFirstTime;
}
