import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/constants/images.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';

sealed class BottomSheetError {
  static void showBottomSheetBox(BuildContext context, VoidCallback onPressed) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        final Size(:width, :height) = MediaQuery.sizeOf(context);
        return Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
          width: width,
          height: height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: AppColors.cardColor,
            image: const DecorationImage(
                opacity: 0.1,
                image: AssetImage(ImagesConstants.scaffoldBackgroundImage),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ops Erro inesperado",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
              const Text("Não foi possível carregar as informações."),
              const Text("Verifique sua conexão e tente novamente"),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Modular.to.pop();
                    onPressed();
                  },
                  child: const Text("Tentar Novamente"))
            ],
          ),
        );
      },
    );
  }
}
