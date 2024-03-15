import 'package:timesync/feature/qr/controller/index.dart';
import 'package:get/get.dart';

class QRBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => QRController()),
      ];
}
