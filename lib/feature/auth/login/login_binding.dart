import 'package:timesync/feature/auth/login/controller/index.dart';
import 'package:get/get.dart';

class LoginBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => LoginController()),
      ];
}
