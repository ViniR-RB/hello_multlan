import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/app_module.dart';
import 'package:hellomultlan/app/app_widget.dart';
import 'package:hellomultlan/app/core/configuration/configuration.dart';
import 'package:hellomultlan/app/pages/error_page.dart';

void main() {
  Configuration.validate();
  runZonedGuarded(
      () => runApp(ModularApp(module: AppModule(), child: const AppWidget())),
      (error, stack) {
    log("Erro Não Tratado", error: error, stackTrace: stack);
    runApp(ErrorPage(message: error.toString()));
  });
}
