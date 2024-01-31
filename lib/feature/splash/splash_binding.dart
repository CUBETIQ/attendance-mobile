import 'package:timesync360/feature/splash/controller/index.dart';
import 'package:get/get.dart';

class SplashBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => SplashController()),
      ];
}
