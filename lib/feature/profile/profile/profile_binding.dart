import 'package:attendance_app/feature/profile/profile/controller/index.dart';
import 'package:get/get.dart';

class ProfileBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => ProfileController()),
      ];
}
