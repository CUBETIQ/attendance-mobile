import 'package:isar/isar.dart';

part 'language.g.dart';

@Collection()
class Languages{
  @Index(unique: true, replace: true)
  Id? id;
  String? enUS;
  String? kmKH;
}