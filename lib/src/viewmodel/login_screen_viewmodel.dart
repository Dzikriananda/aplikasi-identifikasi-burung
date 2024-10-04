
import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:bird_guard/src/route/app_route.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenViewModel extends GetxController {
  Rx<Status> status = Status.idle.obs;
  RxString identifier = ''.obs;
  RxString password = ''.obs;
  AuthRepository repository = locator<AuthRepository>();
  Rxn<BaseResponse> response = Rxn<BaseResponse>();

  void login() async {
    status.value = Status.loading;
    BaseResponse result = await repository.login(
        {
          "identifier": identifier.value,
          "password": password.value
        }
    );
    if(result.status == Status.failed) {
      response.value = result;
      status.value = Status.error;
    } else {
      response.value = result;
      await repository.reOpenDBAfterLogout();
      repository.saveToken(response.value!.data.token);
      await getUserData(response.value!.data.token);
      status.value = Status.success;
      Get.offAllNamed(RouteName.mainScreen);
    }
  }

  void bypassLogin() async {
    status.value = Status.loading;
    await Future.delayed(Duration(seconds: 4));
    await repository.reOpenDBAfterLogout();
    repository.saveToken('null');
    status.value = Status.success;
    Get.offAllNamed(RouteName.mainScreen);



  }

  Future<void> getUserData(String token) async {
    BaseResponse response = await repository.getUserData();
    await repository.saveUserData(response.data);
  }

  void enterPassword(String input)  => password.value = input;
  void enterIdentifier(String input) => identifier.value = input;

}