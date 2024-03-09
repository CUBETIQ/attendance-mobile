import 'package:timesync/feature/qr_scan/controller/index.dart';
import 'package:get/get.dart';

class ScanQRBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => ScanQRController()),
      ];
}
