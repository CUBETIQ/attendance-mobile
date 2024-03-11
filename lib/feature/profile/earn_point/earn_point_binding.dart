import 'package:get/get.dart';
import 'package:timesync/feature/profile/earn_point/controller/index.dart';

class EarnPointBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => EarnPointController()),
      ];
}
