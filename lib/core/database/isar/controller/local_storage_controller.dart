import 'package:attendance_app/core/database/isar/entities/local_storage.dart';
import 'package:attendance_app/core/database/isar/repository/isar_repo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageController extends LocalStorage implements IsarRepository {
  late Future<Isar> db;
  LocalStorageController() {
    db = open();
  }

  @override
  Future<LocalStorage?> get() async {
    final isar = await db;
    final appData = isar.localStorages.filter().idEqualTo(1).findFirstSync();
    return Future.value(appData);
  }

  @override
  Future<void> insert(data) async {
    final isar = await db;
    isar.writeTxnSync(
      () => isar.localStorages.putSync(data),
    );
  }

  @override
  Future<void> clear() async {
    final isar = await db;
    await isar.writeTxn(() => isar.localStorages.clear());
  }

  @override
  Future<Isar> open() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([LocalStorageSchema],
          inspector: true, directory: dir.path);
    }
    return await Future.value(Isar.getInstance());
  }
}
