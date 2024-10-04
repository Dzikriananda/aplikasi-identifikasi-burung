import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/local/local_storage/local_storage.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:bird_guard/src/data/repository/system_repository.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:get/get.dart';

class SplashScreenViewModel extends GetxController {
  AuthRepository authRepository = locator<AuthRepository>();
  SystemRepository systemRepository = locator<SystemRepository>();
  Rxn<AuthStatus> authStatus = Rxn<AuthStatus>();

  Future<void> initSplash() async {
    bool? isAppFirstTimeOpened = await systemRepository.getAppFirstTimeOpened();
    if(isAppFirstTimeOpened==null || isAppFirstTimeOpened) {
      await systemRepository.setAppFirstTimeOpened();
      await authRepository.deleteToken();
    }
    var token = await authRepository.readToken();
    Future.delayed(const Duration(seconds: 2), () {
      if(token == null) {
        authStatus.value = AuthStatus.loggedOut;
        Get.offAllNamed(RouteName.loginScreen);
      } else {
        authStatus.value = AuthStatus.loggedIn;
        Get.offAllNamed(RouteName.mainScreen);
      }
    });
  }




}