import 'package:get/get.dart';
import 'package:timesync/feature/setting/developer_mode/storage_management/controller/storage_management_controller.dart';

class StorageMangementBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => StorageManagementController()),
      ];
}
