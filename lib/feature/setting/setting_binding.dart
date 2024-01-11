import 'package:attendance_app/feature/setting/controller/index.dart';
import 'package:get/get.dart';

class SettingBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => SettingController()),
      ];
}
