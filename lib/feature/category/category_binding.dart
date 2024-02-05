import 'package:get/get.dart';
import 'package:timesync360/feature/category/controller/index.dart';

class CategoryBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => CategoryController()),
      ];
}
