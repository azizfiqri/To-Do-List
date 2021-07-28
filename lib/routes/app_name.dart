import 'package:get/get.dart';
import 'package:notes_keeper_getx/binding/binding.dart';
import 'package:notes_keeper_getx/routes/app_routes.dart';
import 'package:notes_keeper_getx/screens/home_screen.dart';
import 'package:notes_keeper_getx/screens/insert_note_screen.dart';
import 'package:notes_keeper_getx/screens/splash_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteApp.SPLASHSCREEN,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouteApp.HOME,
      page: () => HomeScreen(),
      binding: NoteB(),
    ),
    GetPage(
        name: RouteApp.ADDNOTE,
        page: () => CreateNoteScreen(),
        binding: NoteB()),
  ];
}
