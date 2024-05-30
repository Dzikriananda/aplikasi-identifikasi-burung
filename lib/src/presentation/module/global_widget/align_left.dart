import 'package:flutter/material.dart';

class AlignLeft extends StatelessWidget {
  const AlignLeft({super.key,required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: body
    );
  }
}
