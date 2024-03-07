import 'package:get/get.dart';
import 'package:timesync/feature/position/position_detail/controller/index.dart';

class PositionDetailBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => PositionDetailController()),
      ];
}
