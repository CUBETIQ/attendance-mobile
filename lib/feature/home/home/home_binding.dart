import 'package:timesync360/feature/home/home/controller/index.dart';
import 'package:get/get.dart';

class HomeBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => HomeController()),
      ];
}
