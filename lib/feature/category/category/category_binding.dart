import 'package:get/get.dart';
import 'package:timesync/feature/category/category/controller/index.dart';

class CategoryBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => CategoryController()),
      ];
}
