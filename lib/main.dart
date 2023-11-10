import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/pages/home/home_controller.dart';
import 'src/pages/home/home_state.dart';
import 'src/repositories/local_storage.dart';
import 'src/widget/contact_screen/contact_screen_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var diretory = await getApplicationDocumentsDirectory();
  Hive.init(diretory.path);

  runApp(MultiProvider(providers: [
    Provider<HomeController>(
        create: (_) => HomeController(LocalStorageWithHive(), HomeState())),
    Provider<ContactScreenController>(
        create: (_) => ContactScreenController(LocalStorageWithHive())),
  ], child: const MyApp()));
}
