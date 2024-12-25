import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/app_controller.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';
import 'package:hellomultlan/app/core/widgets/custom_scaffold_foregroud.dart';
import 'package:hellomultlan/app/modules/box/widgets/card_item.dart';

class BoxHub extends StatefulWidget {
  final AppController controller;

  const BoxHub({super.key, required this.controller});

  @override
  State<BoxHub> createState() => _BoxHubState();
}

class _BoxHubState extends State<BoxHub> {
  _logout() {
    if (widget.controller.logout.value == true) {
      Modular.to.navigate("/");
    }
  }

  @override
  void initState() {
    widget.controller.logout.addListener(_logout);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.logout.removeListener(_logout);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // Ícones de status em branco
      statusBarColor: Colors.transparent, // Fundo transparente
    ));
    return CustomScaffoldForegroud(
        child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        const SizedBox(height: 128),
        Text(
          "Selecione uma opção",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w800),
        ),
        CardItem(
          label: "Mapa",
          subTitle: "Visualizar Mapa",
          onTap: () => Modular.to.pushNamed("/box/map"),
          iconSuffix: Icons.map_outlined,
        ),
        CardItem(
          label: "Caixa",
          subTitle: "Adicionar nova caixa",
          onTap: () => Modular.to.pushNamed("/box/form"),
          iconSuffix: Icons.view_in_ar_outlined,
        ),
        CardItem(
          label: "Sair",
          subTitle: "Fazer Logout",
          onTap: () async => await widget.controller.clearSpAndRedirect(),
          iconSuffix: Icons.logout,
        ),
      ],
    ));
  }
}
