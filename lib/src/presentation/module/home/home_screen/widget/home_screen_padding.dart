import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenPadding extends StatelessWidget {
  const HomeScreenPadding({super.key,required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20.w),
      child: child,
    );
  }
}
