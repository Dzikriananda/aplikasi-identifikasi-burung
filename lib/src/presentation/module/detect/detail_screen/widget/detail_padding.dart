import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPadding extends StatelessWidget {
  const DetailPadding({super.key,required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 20.w),
        child: child
    );
  }
}
