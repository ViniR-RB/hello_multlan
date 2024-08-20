import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/modules/box/widgets/card_item.dart';

class BoxHub extends StatelessWidget {
  const BoxHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Selecione uma opção'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            CardItem(
              label: "Ir Para o Mapa",
              onTap: () => Modular.to.pushNamed("/box/map"),
              iconSuffix: Icons.map,
              color: const Color(0xffFFF6E7),
            ),
            CardItem(
              label: "Adicionar uma nova caixa",
              onTap: () => Modular.to.pushNamed("/box/form"),
              iconSuffix: Icons.add_box,
              color: const Color(0xffE5FFE6),
            ),
          ],
        ));
  }
}
