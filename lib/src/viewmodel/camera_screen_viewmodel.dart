
import 'dart:io';

import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreenViewModel extends GetxController {
  late CameraController cameraController;
  BirdRepository repository = locator<BirdRepository>();
  XFile? picture;
  Rx<Status> status = Status.idle.obs;
  Rx<CameraStatus> mediaStatus = CameraStatus.idle.obs;
  Rxn<BaseResponse> response = Rxn();
  String statusMessage = '';
  RxBool isFlashOn = false.obs;

  bool get isLoading {
    return status.value == Status.loading;
  }

  bool get isError {
    return status.value == Status.error;
  }

  bool get isReady {
    return mediaStatus.value == CameraStatus.ready;
  }

  @override
  void onInit() {
    super.onInit();
    prepareCamera();
  }



  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  doFlash() {
    if(isFlashOn.value) {
      cameraController.setFlashMode(FlashMode.off);
    } else {
      cameraController.setFlashMode(FlashMode.torch);
    }
    isFlashOn.value = !isFlashOn.value;
  }


  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      picture = image;
      mediaStatus.value = CameraStatus.hasImage;
      update();
    } on PlatformException catch(e) {
      status.value = Status.error;
    }
  }

  Future takePicture() async {
    try {
      final capturedImage = await cameraController.takePicture();
      picture = capturedImage;
      mediaStatus.value = CameraStatus.hasImage;
      update();
    } catch(_) {
      status.value = Status.error;
    }
  }

  closeDialog() {
    status.value = Status.idle;
    update();

  }


  //For future use (caching)
  Future<String> createImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/images';
    final myDir = Directory(pdfDirectory);
    if (!await myDir.exists()) {
      await myDir.create(recursive: true);
    }
    File image = File(picture!.path);
    DateTime time = DateTime.now();
    String imageDir = '$pdfDirectory/${time.year}-${time.month}-${time.day}-${time.hour}-${time.minute}-${time.second}.jpg';
    await image.copy(imageDir);
    return imageDir;
  }

  // Future<void> uploadImage() async {
  //   status.value = Status.loading;
  //   statusMessage = 'cameraScreenDialog_1'.tr;
  //   update();
  //   // BaseResponse<dynamic> result = await repository.predict(picture!.path);
  //   Map<String,dynamic> dummyData = {
  //     "confidence": {
  //       "002-Curik Bali": 0.22283729631453753,
  //       "009-Raja udang kalung-biru Jawa": 0.01062730370904319,
  //       "010-Sikatan besar": 99.75910186767578
  //     },
  //     "result": "010-Sikatan besar"
  //   };
  //   PredictionResponse data = PredictionResponse.fromJson(dummyData);
  //   String imagePath = await createImage();
  //   await locator<LocalStorage>().saveObject(DetailModel(imagePath: imagePath, data: data));
  //
  //
  //   // if(result.status == Status.success) {
  //   //   // PredictionResponse predictData = result.data!;
  //   //   // BaseResponse<PredictionResponse> data = Base;
  //   //   response.value = result;
  //   //   status.value = Status.success;
  //   //   Get.offNamed(RouteName.detailScreen,arguments: {'response' : response.value, "imagePath" : picture!.path});
  //   // } else {
  //   //   response.value = result;
  //   //   statusMessage = result.message ?? 'Error';
  //   //   status.value = Status.error;
  //   // }
  //   // update();
  // }

  // Future<void> upload() async {
  //   BaseResponse<dynamic> result = await repository.predictV2(picture!.path);
  // }


  Future<void> uploadImage() async {
    await createImage();
    status.value = Status.loading;
    statusMessage = 'cameraScreenDialog_1'.tr;
    update();
    BaseResponse<dynamic> result = await repository.predictV2(picture!.path);
    // Map<String,dynamic> dummyData = {
    //   "confidence": {
    //     "002-Curik Bali": 0.22283729631453753,
    //     "009-Raja udang kalung-biru Jawa": 0.01062730370904319,
    //     "010-Sikatan besar": 99.75910186767578
    //   },
    //   "result": "010-Sikatan besar"
    // };
    // BaseResponse<PredictionResponse> result = BaseResponse.fromJson(null,null,Status.success,PredictionResponse.fromJson(dummyData));
    // await Future.delayed(Duration(seconds: 2));
    if(result.status == Status.success) {
      response.value = result;
      status.value = Status.success;
      Get.offNamed(RouteName.detailScreen,arguments: {'response' : response.value, "imagePath" : picture!.path});
    } else {
      response.value = result;
      statusMessage = result.message ?? 'Error';
      status.value = Status.error;
    }
    update();
  }

  retakePicture() {
    mediaStatus.value = CameraStatus.ready;
    update();
  }

  askCameraPermission() async {
    var permissionStatus = await Permission.camera.status;
    if(permissionStatus.isDenied) {
      await Permission.camera
          .onDeniedCallback(() {
            status.value =  Status.error;
            mediaStatus.value = CameraStatus.denied;
            statusMessage = 'cameraScreenDialog_2'.tr;
            update();
      })
          .onGrantedCallback(() {
            status.value =  Status.idle;
            update();
            prepareCamera();
      })
          .onPermanentlyDeniedCallback(() {
            status.value =  Status.error;
            mediaStatus.value = CameraStatus.denied;
            statusMessage = 'cameraScreenDialog_3'.tr;
            update();
      })
          .onRestrictedCallback(() {
      })
          .onLimitedCallback(() {
      })
          .onProvisionalCallback(() {
      })
          .request();
    } else if(permissionStatus.isPermanentlyDenied) {
      statusMessage = 'cameraScreenDialog_3'.tr;
      update();
    }

  }

  prepareCamera() async {
    List<CameraDescription> cameras = Get.arguments;
    cameraController = CameraController(cameras[0], ResolutionPreset.max,enableAudio: false);
    cameraController.initialize().then((_) {
      mediaStatus.value = CameraStatus.ready;
      update();
    }).catchError((Object e) {
      if (e is CameraException) {
        status.value = Status.error;
        switch (e.code) {
          case 'CameraAccessDenied':
            mediaStatus.value = CameraStatus.denied;
            statusMessage = 'cameraScreenDialog_2'.tr;
            break;
          default:
            statusMessage = 'Error : ${e.code}';
            break;
        }
      }
      update();
    });
  }

}