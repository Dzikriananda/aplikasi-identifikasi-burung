import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/user_model/user_model.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  AuthRepository authRepository = locator<AuthRepository>();
  UserModel? userData;

  @override
  void onInit() {
    super.onInit();
    configureProfile();
  }

  configureProfile() async {
    userData = await authRepository.getLocalUserData();
    update();
  }



}