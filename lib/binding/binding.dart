import 'package:get/get.dart';
import 'package:notes_keeper_getx/controllers/note_controller.dart';

class NoteB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteController>(() => NoteController());
  }
}
