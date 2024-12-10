import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';
import 'package:hellomultlan/app/core/theme/app_theme.dart';

class CardItem extends StatelessWidget {
  final String label;
  final String subTitle;
  final IconData iconSuffix;

  final void Function()? onTap;
  const CardItem({
    super.key,
    required this.label,
    required this.subTitle,
    required this.iconSuffix,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.only(top: 16),
        height: 87,
        decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [AppTheme.boxShadowDefault]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Icon(
                    iconSuffix,
                    size: 42,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text.rich(TextSpan(
                    text: "$label\n",
                    children: [
                      TextSpan(
                          text: subTitle,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w200))
                    ],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  const Spacer(),
                  const Icon(
                    Icons.chevron_right,
                    size: 42,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
