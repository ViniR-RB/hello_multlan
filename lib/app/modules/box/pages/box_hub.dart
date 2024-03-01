import 'package:flutter/material.dart';
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
              onTap: () => Navigator.of(context).pushNamed("/box/map"),
              iconSuffix: Icons.map,
              color: const Color(0xffFFF6E7),
            ),
            CardItem(
              label: "Adicionar uma nova caixa",
              onTap: () => Navigator.of(context).pushNamed("/box/form"),
              iconSuffix: Icons.map,
              color: const Color(0xffE5FFE6),
            ),
          ],
        ));
  }
}
