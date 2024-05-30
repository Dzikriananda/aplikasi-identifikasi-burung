import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/local/local_storage/local_storage.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:get/get.dart';

class SplashScreenViewModel extends GetxController {
  AuthRepository repository = locator<AuthRepository>();
  Rxn<AuthStatus> authStatus = Rxn<AuthStatus>();

  Future<void> initSplash() async {
    var token = await repository.readToken();
    print(token ?? "not login");
    Future.delayed(Duration(seconds: 2), () {
      if(token == null) {
        authStatus.value = AuthStatus.loggedOut;
        Get.offAllNamed(RouteName.loginScreen);
        // Get.offAllNamed(RouteName.mainScreen);
      } else {
        authStatus.value = AuthStatus.loggedIn;
        Get.offAllNamed(RouteName.mainScreen);
      }
    });
  }

}