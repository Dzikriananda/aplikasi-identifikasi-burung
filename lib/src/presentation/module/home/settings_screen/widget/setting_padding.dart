import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingPadding extends StatelessWidget {
  const SettingPadding({super.key,required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 25.w),
      child: child
    );
  }
}
