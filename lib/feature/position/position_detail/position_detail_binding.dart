import 'package:get/get.dart';
import 'package:timesync360/feature/position/position_detail/controller/index.dart';

class PositionDetailBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => PositionDetailController()),
      ];
}
