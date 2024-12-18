import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/constants/images.dart';
import 'package:hellomultlan/app/core/extensions/number_pad.dart';
import 'package:hellomultlan/app/core/models/box_model.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_edit_controller.dart';
import 'package:hellomultlan/app/modules/box/widgets/box_field_detail.dart';

sealed class BoxDetailsBottomSheet {
  static void showBottomSheetBox(
      BoxModel box, BoxEditController controller, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        final Size(:width) = MediaQuery.sizeOf(context);
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
            image: DecorationImage(
              opacity: 0.1,
              image: AssetImage(ImagesConstants.scaffoldBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 89,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.8,
                minChildSize: 0.8,
                maxChildSize: 1,
                builder: (context, scrollController) => Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: width,
                            height: 256,
                            child: InteractiveViewer(
                              panEnabled: true,
                              scaleEnabled: true,
                              child: Image.network(
                                controller.boxModel.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                        child: Icon(Icons.image_not_supported)),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Text(
                          "Informações gerais",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            BoxFieldDetail(
                              label: "Espaço Total:",
                              value: box.freeSpace.toString().padZero(),
                            ),
                            BoxFieldDetail(
                              label: "Clientes ativos:",
                              value: box.filledSpace.toString().padZero(),
                            ),
                            BoxFieldDetail(
                              label: "Clientes:",
                              value: box.listUsers
                                  .toString()
                                  .replaceFirst("[", "")
                                  .replaceFirst("]", ""),
                            ),
                            BoxFieldDetail(
                              label: "Sinal:",
                              value: box.signal.toStringAsFixed(1),
                            ),
                            Visibility(
                              replacement: const SizedBox.shrink(),
                              child: BoxFieldDetail(
                                label: "Nota",
                                value: box.note ?? "",
                              ),
                            )
                          ],
                        ),
                      ),
                      // Botão de Edição
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: ElevatedButton(
                          onPressed: () => Modular.to.pushNamed(
                            "/box/edit",
                            arguments: controller,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Editar",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
