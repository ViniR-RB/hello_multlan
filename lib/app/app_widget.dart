import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hellomultlan/app/core/bindings/app_aplication_bindings.dart';
import 'package:hellomultlan/app/core/theme/app_theme.dart';
import 'package:hellomultlan/app/core/widgets/custom_loader.dart';
import 'package:hellomultlan/app/modules/auth/auth_module.dart';
import 'package:hellomultlan/app/modules/box/box_module.dart';
import 'package:hellomultlan/app/pages/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      bindings: AppAplicationBindings(),
      pages: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: "/"),
      ],
      modules: [
        AuthModule(),
        BoxModule(),
      ],
      builder: (context, routes, flutterGetItNavObserver) => AsyncStateBuilder(
        loader: CustomLoader(),
        builder: (navigatorObserver) => MaterialApp(
          title: 'Hello Multlan',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lighTheme,
          darkTheme: AppTheme.darkTheme,
          navigatorObservers: [navigatorObserver, flutterGetItNavObserver],
          routes: routes,
        ),
      ),
    );
  }
}
