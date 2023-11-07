// ignore_for_file: void_checks

import 'package:cubetiq_attendance_app/data/isar/entities/language.dart';
import 'package:cubetiq_attendance_app/data/isar/entities/storageConfig.dart';
import 'package:cubetiq_attendance_app/data/isar/repository/isar_repo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class StorageServiceImp extends StorageConfigure implements IsarRepository {
  late Future<Isar> db;
  StorageServiceImp() {
    db = openIsar();
  }

  @override
  Future<StorageConfigure?> fetchData() async {
    final isar = await db;
    final appData =
        isar.storageConfigures.filter().idEqualTo(1).findFirstSync();
    return Future.value(appData);
  }

  @override
  Future<void> insertData(data) async {
    final isar = await db;
    isar.writeTxnSync(
      () => isar.storageConfigures.putSync(data),
    );
  }

  @override
  Future<void> clearData() async {
    final isar = await db;
    await isar.writeTxn(() => isar.storageConfigures.clear());
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
