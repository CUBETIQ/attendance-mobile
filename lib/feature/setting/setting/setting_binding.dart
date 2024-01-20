import 'package:get/get.dart';
import 'controller/index.dart';

class SettingBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => SettingController()),
      ];
}
