import 'package:get/get.dart';
import 'controller/index.dart';

class TaskBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(() => TaskController()),
      ];
}
