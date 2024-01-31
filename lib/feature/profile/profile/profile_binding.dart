import 'package:timesync360/feature/profile/profile/controller/index.dart';
import 'package:get/get.dart';

class ProfileBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => ProfileController()),
      ];
}
