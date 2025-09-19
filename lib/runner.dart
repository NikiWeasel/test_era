import 'package:flutter/material.dart';
import 'package:test_project/app/app.dart';
import 'package:test_project/app/di/app_dependencies.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDI();

  runApp(App());
}
