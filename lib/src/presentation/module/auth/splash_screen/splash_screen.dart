import 'package:bird_guard/src/core/gen/assets.gen.dart';
import 'package:bird_guard/src/viewmodel/splash_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashScreenViewModel> {
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    controller.initSplash();
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "logo",
          child: Image.asset(Assets.images.logoNoBackground.path,height: 100.h),
        ),
      ),
    );
  }
}
