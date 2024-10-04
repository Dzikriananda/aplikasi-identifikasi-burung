
import 'package:bird_guard/src/core/constant/map_constant.dart';
import 'package:bird_guard/src/presentation/module/global_widget/primary_button.dart';
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
            content: CircularProgressIndicator(),
            title: 'Loading',
            barrierDismissible: false
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
            barrierDismissible: false,
            content: Icon(Icons.error_sharp,size: 50),
            title:  'Error : ${message!}',
            titleStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            confirm: PrimaryButton(
                onPressed: () {
                  onOk();
                  Get.back();
                }
            ),
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

  static Color getStatusColor(String conversationStatusString) {
    print(conversationStatusString);
    late ConversationStatus status;
    MapConstant.conversationStatusMap.forEach((key, value) {
      if(conversationStatusString == key) {
        status = value;
      }
    });
    switch(status) {
      case ConversationStatus.lc : {
        return Colors.green;
      }
      case ConversationStatus.vu : {
        return Colors.yellow[700]!;
      }
      case ConversationStatus.nt : {
        return Colors.yellow[700]!;
      }
      case ConversationStatus.en : {
        return Colors.red;
      }
      case ConversationStatus.cr: {
        return Colors.red;
      }
      default: {
        return Colors.black;
      }
    }
  }

}