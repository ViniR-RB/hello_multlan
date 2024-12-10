import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/app_module.dart';
import 'package:hellomultlan/app/app_widget.dart';
import 'package:hellomultlan/app/core/configuration/configuration.dart';
import 'package:hellomultlan/app/pages/error_page.dart';

import "firebase_options.dart";

Future<void> main() async {
  runZonedGuarded(() async {
    Configuration.validate();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  }, (error, stack) {
    log("Erro Não Tratado", error: error, stackTrace: stack);
    runApp(ErrorPage(message: error.toString()));
  });
}
