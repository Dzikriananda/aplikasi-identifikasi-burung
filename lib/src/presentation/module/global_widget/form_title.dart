import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({super.key,required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: CustomColor.neutralTextColor
      ),
    );
  }
}
