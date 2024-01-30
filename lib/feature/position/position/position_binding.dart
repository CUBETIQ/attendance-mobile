import 'package:get/get.dart';
import 'controller/index.dart';

class PositionBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => PositionController()),
      ];
}
