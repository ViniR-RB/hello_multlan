import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';

class CustomAppBar extends PreferredSize {
  final String title;
  CustomAppBar({Key? key, required this.title})
      : super(
          key: key,
          preferredSize: const Size.fromHeight(96),
          child: AppBar(
            title: Text(title),
            leading: Modular.to.canPop()
                ? IconButton(
                    icon: const Icon(Icons.chevron_left, size: 40),
                    onPressed: () => Modular.to.pop(),
                  )
                : const SizedBox.shrink(),
            iconTheme: IconThemeData(color: AppColors.primaryColor),
            titleTextStyle: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 26,
                fontWeight: FontWeight.w800),
            centerTitle: true,
            elevation: 12,
            shadowColor: const Color(0xFF999999),
          ),
        );
}
