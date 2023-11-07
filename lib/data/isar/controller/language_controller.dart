import 'package:cubetiq_attendance_app/data/isar/entities/language.dart';
import 'package:cubetiq_attendance_app/data/isar/entities/storageConfig.dart';
import 'package:cubetiq_attendance_app/data/isar/repository/isar_repo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LanguageServiceIsar extends IsarRepository<Languages> {
  late Future<Isar> db;
  LanguageServiceIsar() {
    db = openIsar();
  }

  @override
  Future<Languages?> fetchData() async {
    final isar = await db;
    final appData = isar.languages.filter().idEqualTo(1).findFirstSync();
    return Future.value(appData);
  }

  @override
  Future<void> insertData(Languages data) async {
    final isar = await db;
    isar.writeTxnSync(
      () => isar.languages.putSync(data),
    );
  }

  @override
  Future<void> clearData() async {
    final isar = await db;
    await isar.writeTxn(() => isar.languages.clear());
  }

  @override
  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([
        StorageConfigureSchema,
        LanguagesSchema,
      ], inspector: true, directory: dir.path);
    }
    return await Future.value(Isar.getInstance());
  }
}
