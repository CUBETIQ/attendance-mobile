import 'package:get/get.dart';
import 'package:timesync/feature/organization/generate_qr/controller/index.dart';

class GenerateQRBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => GenerateQRController()),
      ];
}
