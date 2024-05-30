import 'package:bird_guard/src/viewmodel/camera_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class HasPictureBottomBar extends GetView<CameraScreenViewModel> {
  const HasPictureBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        const SizedBox(width: 15),
        Expanded(
          child: OutlinedButton(
              onPressed: () => controller.retakePicture(),
              style: OutlinedButton.styleFrom(
                // backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                side: BorderSide(width: 3.0, color: Theme.of(context).colorScheme.primary),
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text('Retake photo'.tr,style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
              ))
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
              onPressed: () => controller.uploadImage(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text('Scan this image'.tr,style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
              ))
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
