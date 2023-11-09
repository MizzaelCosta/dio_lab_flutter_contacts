import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/pages/add/add_contact_controller.dart';
import 'src/pages/home/home_controller.dart';
import 'src/pages/home/home_state.dart';
import 'src/repositories/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var diretory = await getApplicationDocumentsDirectory();
  Hive.init(diretory.path);

  runApp(MultiProvider(providers: [
    Provider<HomeController>(
        create: (_) => HomeController(LocalStorageWithHive(), HomeState())),
    Provider<AddContactController>(
        create: (_) => AddContactController(LocalStorageWithHive())),
  ], child: const MyApp()));
}
