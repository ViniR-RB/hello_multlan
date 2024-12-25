import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/app_controller.dart';
import 'package:hellomultlan/app/core/widgets/button_sheet_error.dart';
import 'package:hellomultlan/app/core/widgets/custom_scaffold_primary.dart';
import 'package:hellomultlan/app/core/widgets/logo_widget.dart';

class SplashPage extends StatefulWidget {
  final AppController contoller;
  const SplashPage({super.key, required this.contoller});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final ValueNotifier<double> _opacityNotifier = ValueNotifier(0.0);
  Future<void> init() async {
    await _animatedLogo();
    await widget.contoller.healthCheckApi();
  }

  Future<void> _animatedLogo() async {
    Future.delayed(const Duration(seconds: 1), () {
      _opacityNotifier.value = 1.0;
    });
  }

  redirectUser() {
    if (widget.contoller.isAuthenticated.value == true) {
      Modular.to.navigate(
        "/box/",
      );
    } else {
      Modular.to.navigate("/auth/login");
    }
  }

  showButtonSheet() {
    if (widget.contoller.apiOffline.value == true) {
      BottomSheetError.showBottomSheetBox(
          context, () async => await widget.contoller.healthCheckApi());
    }
  }

  @override
  void initState() {
    init();
    widget.contoller.isAuthenticated.addListener(redirectUser);
    widget.contoller.apiOffline.addListener(showButtonSheet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScaffoldPrimary(
        child: Center(
          child: ValueListenableBuilder<double>(
            valueListenable: _opacityNotifier,
            builder: (context, opacity, child) {
              return AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                child: child,
              );
            },
            child: const LogoWidget(
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
