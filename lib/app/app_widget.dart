import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, // Ícones de status em branco
      statusBarColor: Colors.transparent, // Fundo transparente
    ));
    return MaterialApp.router(
      title: 'Hello Multlan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lighTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: Modular.routerConfig,
    );
  }
}
