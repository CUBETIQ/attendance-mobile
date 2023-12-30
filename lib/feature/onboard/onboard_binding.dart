import 'package:attendance_app/feature/onboard/controller/index.dart';
import 'package:get/get.dart';

class OnBoardBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => OnBoardController()),
      ];
}
