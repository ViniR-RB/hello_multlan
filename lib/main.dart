import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hellomultlan/app/app_widget.dart';

void main() {
  runZonedGuarded(() => runApp(const AppWidget()), (error, stack) {
    log("Erro Não Tratado", error: error, stackTrace: stack);
    throw error;
  });
}
