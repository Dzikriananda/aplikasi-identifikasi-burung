import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.prefixIcon,
    this.suffixIcon,
    this.onTap
  });

  final String title;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // print(CustomColor.surfaceContainerHighest);
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.surfaceContainerHighest,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.35),
        //     spreadRadius: 2,
        //     blurRadius: 2,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      child: Row(
        children: [
          prefixIcon,
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          SizedBox(width: 10),
          (suffixIcon == null) ? InkWell(
            onTap: onTap,
            child: const Icon(Icons.arrow_forward_ios),
          ) : suffixIcon!
        ],
      ),
    );
  }
}
