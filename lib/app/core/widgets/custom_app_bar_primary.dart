import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/constants/images.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';

class CustomAppBar extends PreferredSize {
  final String title;
  final List<Widget>? actions;
  CustomAppBar({Key? key, required this.title, this.actions})
      : super(
          key: key,
          preferredSize: const Size.fromHeight(96),
          child: AppBar(
            actions: actions,
            title: Text(title),
            leading: Modular.to.canPop()
                ? IconButton(
                    icon: const Icon(Icons.chevron_left, size: 40),
                    onPressed: () => Modular.to.pop(),
                  )
                : const SizedBox.shrink(),
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: const TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800),
            backgroundColor: AppColors.primaryColor,
            centerTitle: true,
            elevation: 12,
            flexibleSpace: const CustomAppBarContent(),
            shadowColor: const Color(0xFF999999),
          ),
        );
}

class CustomAppBarContent extends StatelessWidget {
  const CustomAppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: 0.45,
          image: AssetImage(
              ImagesConstants.scaffoldBackgroundImage), // URL da imagem
          fit: BoxFit.fitWidth, // Garantir que a imagem cubra toda a área
        ),
      ),
    );
  }
}
