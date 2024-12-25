import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/constants/images.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const CustomSliverAppBar({Key? key, required this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      elevation: 12,
      shadowColor: const Color(0xFF999999),

      iconTheme: IconThemeData(color: AppColors.cardColor),
      flexibleSpace: Container(
        padding: const EdgeInsets.only(top: 32),
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.45,
            image: AssetImage(ImagesConstants.scaffoldBackgroundImage),
            fit: BoxFit.fitWidth,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.cardColor,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: actions,
      leading: Modular.to.canPop()
          ? IconButton(
              icon: const Icon(Icons.chevron_left, size: 40),
              onPressed: () => Modular.to.pop(),
            )
          : const SizedBox.shrink(),
      backgroundColor: AppColors.primaryColor, // Cor de fundo do AppBar
    );
  }
}
