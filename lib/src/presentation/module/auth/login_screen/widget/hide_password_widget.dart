import 'package:flutter/material.dart';

class HidePasswordButton extends StatefulWidget {
  const HidePasswordButton({super.key,required this.function});
  final VoidCallback function;

  @override
  State<HidePasswordButton> createState() => _HidePasswordButtonState();
}

class _HidePasswordButtonState extends State<HidePasswordButton> {
  bool hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.function();
        setState(() {
          hidePassword = !hidePassword;
        });
      },
      icon: Icon(
          Icons.remove_red_eye,
          color: (hidePassword) ?
               Colors.blue : Colors.black
      )
    );
  }
}
