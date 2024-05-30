import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/viewmodel/camera_screen_viewmodel.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class TakingPictureBottomBar extends GetView<CameraScreenViewModel> {
  const TakingPictureBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !controller.isReady,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo,size: 30),
            onPressed: () {
              controller.pickImage();
            },
          ),
          SizedBox(
            width: 60.w,
            child: FittedBox(
              child:  FloatingActionButton(
                onPressed: () => controller.takePicture(),
                tooltip: 'Increment',
                child: Icon(Icons.camera_alt_rounded),
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          Obx(
                () => IconButton(
                icon: Icon(
                    Icons.flash_on,size: 30,
                    color: controller.isFlashOn.value ? Colors.blue : null
                ),
                onPressed: () => controller.doFlash()
            ),
          )
        ],
      ),
    );
  }
}
