import 'package:get/get.dart';
import 'package:timesync360/feature/category/category_detail/controller/index.dart';

class CategoryDetailBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => CategoryDetailController()),
      ];
}
