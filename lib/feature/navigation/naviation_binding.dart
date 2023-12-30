import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:get/get.dart';

class NavigationBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => NavigationController()),
      ];
}
