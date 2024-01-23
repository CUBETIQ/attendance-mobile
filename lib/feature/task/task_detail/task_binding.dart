import 'package:get/get.dart';
import 'controller/index.dart';

class TaskDetailBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => TaskDetailController()),
      ];
}
