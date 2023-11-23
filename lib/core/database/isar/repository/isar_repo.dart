import 'dart:core';

import 'package:isar/isar.dart';

abstract class IsarRepository<T> {
  Future<void> clear();
  Future<void> insert(T data);
  Future<T?> get();
  Future<Isar> open();
}
