import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String label;
  final IconData iconSuffix;
  final Color color;
  final void Function()? onTap;
  const CardItem({
    super.key,
    required this.label,
    required this.iconSuffix,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.only(top: 16),
        height: 76,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Icon(iconSuffix),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
