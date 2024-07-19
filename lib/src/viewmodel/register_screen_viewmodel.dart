
import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/register_model.dart';
import 'package:get/get.dart';

import '../data/model/base_response.dart';
import '../data/repository/auth_repository.dart';

class RegisterScreenViewModel extends GetxController {
  Rx<Status> status = Status.idle.obs;
  RxString username = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString password_1 = ''.obs;
  RxString password_2 = ''.obs;
  AuthRepository repository = locator<AuthRepository>();
  Rxn<BaseResponse> response = Rxn<BaseResponse>();
  RxInt currentPage = 0.obs;
  RxBool isMoving = false.obs;
  RxBool isIdle = true.obs;
  RxBool isPasswordMatched = true.obs;


  void register() async {
    status.value = Status.loading;
    RegisterModel data = RegisterModel(
      username: username.value,
      email: email.value,
      password: password_1.value,
      name: name.value,
      phone: phoneNumber.value
    );
    BaseResponse result = await repository.register(data.toJson());
    if(result.status == Status.failed) {
      response.value = result;
      status.value = Status.error;
    } else {
      response.value = result;
      status.value = Status.success;
    }
  }

  String? getEmailInitialValue() {
    if(email.value.length == 0) {
      return null;
    } else {
      return email.value;
    }
  }

  String? getUsernameInitialValue() {
    if(username.value.length == 0) {
      return null;
    } else {
      return username.value;
    }
  }

  String? getFullnameInitialValue() {
    if(name.value.length == 0) {
      return null;
    } else {
      return name.value;
    }
  }

  void checkPasswordValue() {
    if(password_1.value == password_2.value) {
      isPasswordMatched.value = true;
    } else {
      isPasswordMatched.value = false;
    }
  }

  void forwardForm() async {
    isMoving.value = true;
    isIdle.value = false;
    await Future.delayed(Duration(milliseconds: 500),(){
      currentPage.value++;
    });
    isMoving.value = false;
    isIdle.value = true;
  }

  void backForm() async {
    isMoving.value = true;
    isIdle.value = false;
    await Future.delayed(Duration(milliseconds: 500),(){
      currentPage.value--;
    });
    isMoving.value = false;
    isIdle.value = true;
  }

  void enterFirstPassword(String input)  => password_1.value = input;
  void enterSecondPassword(String input)  => password_2.value = input;
  void enterUsername(String input) => username.value = input;
  void enterEmail(String input) => email.value = input;
  void enterName(String input) => name.value = input;
  void enterPhoneNumber(String input) => phoneNumber.value = input;



}