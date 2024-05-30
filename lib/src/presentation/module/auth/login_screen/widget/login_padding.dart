import 'package:flutter/material.dart';

class LoginPadding extends StatelessWidget {
  const LoginPadding({super.key,required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
        child: body
    );
  }
}
