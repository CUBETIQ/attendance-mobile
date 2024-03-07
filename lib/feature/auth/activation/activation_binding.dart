import 'package:timesync/feature/auth/activation/controller/index.dart';
import 'package:get/get.dart';

class ActivationBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => ActivationController()),
      ];
}
