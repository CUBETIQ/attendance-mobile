import 'package:timesync360/core/database/isar/entities/language.dart';
import 'package:timesync360/core/database/isar/entities/local_storage.dart';
import 'package:timesync360/core/database/isar/repository/isar_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LanguageLocalStorageController extends Languages
    implements IsarRepository {
  static LanguageLocalStorageController? _instance;
  late Future<Isar> _db;

  LanguageLocalStorageController._internal() {
    _db = open();
  }

  factory LanguageLocalStorageController.getInstance() {
    _instance ??= LanguageLocalStorageController._internal();
    return _instance!;
  }

  factory LanguageLocalStorageController.createNewInstance() {
    return LanguageLocalStorageController._internal();
  }

  @override
  Future<Languages?> get() async {
    final isar = await _db;
    return isar.languages.filter().idEqualTo(1).findFirstSync();
  }

  @override
  Future<void> insert(data) async {
    final isar = await _db;
    isar.writeTxnSync(() => isar.languages.putSync(data));
  }

  @override
  Future<void> clear() async {
    final isar = await _db;
    await isar.writeTxn(() => isar.languages.clear());
  }

  @override
  Future<Isar> open() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return Isar.open([LanguagesSchema, LocalStorageSchema],
          inspector: kDebugMode ? true : false, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }
}
