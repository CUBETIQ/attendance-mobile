import 'package:attendance_app/core/database/isar/entities/local_storage.dart';
import 'package:attendance_app/core/database/isar/repository/isar_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageController extends LocalStorage implements IsarRepository {
  static LocalStorageController? _instance;
  late Future<Isar> _db;

  LocalStorageController._internal() {
    _db = open();
  }

  factory LocalStorageController.getInstance() {
    _instance ??= LocalStorageController._internal();
    return _instance!;
  }

  factory LocalStorageController.createNewInstance() {
    return LocalStorageController._internal();
  }

  @override
  Future<LocalStorage?> get() async {
    final isar = await _db;
    return isar.localStorages.filter().idEqualTo(1).findFirstSync();
  }

  @override
  Future<void> insert(data) async {
    final isar = await _db;
    isar.writeTxnSync(() => isar.localStorages.putSync(data));
  }

  @override
  Future<void> clear() async {
    final isar = await _db;
    await isar.writeTxn(() => isar.localStorages.clear());
  }

  @override
  Future<Isar> open() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return Isar.open([LocalStorageSchema],
          inspector: kDebugMode ? true : false, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }
}
