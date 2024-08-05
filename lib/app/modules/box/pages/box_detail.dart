import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_edit_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BoxDetail extends StatelessWidget {
  final BoxEditController controller;
  const BoxDetail({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                Modular.to.pushNamed("/box/edit", arguments: controller),
            icon: const Icon(Icons.mode_edit),
          ),
        ],
      ),
      body: Watch.builder(
        builder: (_) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  height: height * 0.5,
                  decoration: const BoxDecoration(),
                  child: InteractiveViewer(
                    maxScale: 5,
                    child: Image.network(
                      controller.boxModel.image,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(Icons.area_chart),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(controller.boxModel.id),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.people,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text("Espaço total: ${controller.boxModel.freeSpace}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.menu),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Clientes Ativos: ${controller.boxModel.filledSpace}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.account_box),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(controller.boxModel.listUsers.toString(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.update),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(controller.boxModel.note ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
