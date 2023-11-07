import 'dart:core';

import 'package:isar/isar.dart';

abstract class IsarRepository<T> {
  Future<void> clearData();
  Future<void> insertData(T data);
  Future<T?> fetchData();
  Future<Isar> openIsar();
}
