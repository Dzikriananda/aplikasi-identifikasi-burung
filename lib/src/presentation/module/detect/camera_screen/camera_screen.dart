import 'dart:io';
import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:bird_guard/src/presentation/module/detect/camera_screen/widget/has_picture_bottom_bar.dart';
import 'package:bird_guard/src/presentation/module/detect/camera_screen/widget/taking_picture_bottom_bar.dart';
import 'package:bird_guard/src/presentation/module/global_widget/custom_dialog.dart';
import 'package:bird_guard/src/presentation/module/global_widget/stateful_handle_widget.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:bird_guard/src/viewmodel/camera_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraScreenViewModel>(
      builder: (controller) {
        return Scaffold(
            body: StatefulHandleWidget(
              body: Center(
                child: Column(
                  children: [
                    Builder(
                        builder: (context) {
                          if (controller.mediaStatus.value == CameraStatus.ready) {
                            return Expanded(
                              child: controller.cameraController.buildPreview(),
                            );
                          } else if (controller.mediaStatus.value == CameraStatus.hasImage) {
                            return Expanded(
                              child: Image.file(File(controller.picture!.path)),
                            );
                          } else {
                            return const Expanded(
                              child: SizedBox(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                        }
                    ),
                    SizedBox(height: 15),
                    IgnorePointer(
                      ignoring: (controller.status.value == Status.loading),
                      child: Builder(
                          builder: (context) {
                            if(controller.mediaStatus.value == CameraStatus.ready) {
                              return TakingPictureBottomBar();
                            } else if(controller.mediaStatus.value == CameraStatus.hasImage) {
                              return HasPictureBottomBar();
                            } else {
                              return TakingPictureBottomBar();
                            }
                          }
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                )
              ),
              loadingEnabled: controller.isLoading,
              loadingView: CustomDialog(message: controller.statusMessage),
              errorEnabled: controller.isError,
              errorView: CustomDialog(
                  isError: true,
                  message: controller.statusMessage,
                  ignoreClick: false,
                  onPressed: () {
                    if(controller.mediaStatus.value == CameraStatus.denied) {
                      controller.askCameraPermission();
                    } else if(controller.response.value?.statusCode == 401) {
                      locator<AuthRepository>().logOut();
                      Get.offAllNamed(RouteName.loginScreen);
                    } else {
                      controller.closeDialog();
                    }
                  }
              ),
              stackLoadingWidget: true,
            ),
        );
      }
    );
  }
}
