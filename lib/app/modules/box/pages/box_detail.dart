import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/models/box_model.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_map_controller.dart';

class BoxDetail extends StatelessWidget {
  final BoxModel boxModel;
  final BoxMapController controller;
  const BoxDetail(
      {super.key, required this.boxModel, required this.controller});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.mode_edit),
            ),
          ],
        ),
        body: Padding(
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
                      boxModel.imageUrl,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Espaço total: ${boxModel.totalClient}"),
                    const SizedBox(
                      width: 16,
                    ),
                    Text("Clientes Ativos: ${boxModel.activatedClient}"),
                  ],
                ),
                Text(boxModel.reference)
              ],
            ),
          ),
        ));
  }
}
