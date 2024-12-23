import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/constants/images.dart';
import 'package:hellomultlan/app/core/extensions/number_pad.dart';
import 'package:hellomultlan/app/core/extensions/timeago.dart';
import 'package:hellomultlan/app/core/models/box_model.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_edit_controller.dart';
import 'package:hellomultlan/app/modules/box/widgets/box_field_detail.dart';

sealed class BoxDetailsBottomSheet {
  static void showBottomSheetBox(
      BoxModel box, BoxEditController controller, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final Size(:width, :height) = MediaQuery.sizeOf(context);
        return SizedBox(
          child: Container(
            height: height,
            padding: const EdgeInsets.only(top: 32),
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
            child: ListView(
              shrinkWrap: true,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                      BoxFieldDetail(
                        label: "Nota",
                        value:
                            box.note!.isEmpty ? "Sem Atualização" : box.note!,
                      ),
                      BoxFieldDetail(
                        label: "Ultima Atualização",
                        value: box.createdAt.toTimeAgo(),
                      ),
                    ],
                  ),
                ),
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
        );
      },
    );
  }
}
