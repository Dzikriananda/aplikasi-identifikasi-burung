
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/enum.dart';

class Helper {
  static listenForEvent(bool needToShowSuccess,Status status,String? message,VoidCallback onOk, VoidCallback onClose,VoidCallback? onSuccessClose) {
    switch(status) {
      case Status.loading : {
        if(Get.isDialogOpen!) {
          Get.back();
        }
        Get.defaultDialog(
            barrierDismissible: false,
            content: CircularProgressIndicator(),
            title: 'Loading'
        );
      }
      case Status.success : {
        if(Get.isDialogOpen!) {
          Get.back();
        }
        if(needToShowSuccess) {
          Get.defaultDialog(
              content: Icon(Icons.check),
              title: 'Success',
              buttonColor: Color(0xff3D5AA9),
              onConfirm: () {
                if(onSuccessClose!=null) {
                  onSuccessClose!();
                }
                Get.back();
              },
              onWillPop: () async {
                if(onSuccessClose!=null) {
                  onSuccessClose!();
                }
                return true;
              }
          );
        }
      }
      case Status.error: {
        if(Get.isDialogOpen!) {
          Get.back();
        }
        Get.defaultDialog(
            content: Icon(Icons.error_outlined),
            title:  'Error : ${message!}',
            titleStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            onConfirm: () {
              onOk();
              Get.back();
            },
            buttonColor: Color(0xff3D5AA9),
            onWillPop: () async {
              onClose();
              return true;
            }
        );
      }
      case Status.empty: null;
      case Status.started: null;
      case Status.failed: null;
      case Status.idle: null;
    }
  }
}