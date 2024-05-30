import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/core/styles/theme.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:bird_guard/src/data/repository/system_repository.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SystemController extends GetxController {

  late bool isDarkTheme;
  late Locale currentLocale;
  SystemRepository repository = locator<SystemRepository>();
  AuthRepository authRepository = locator<AuthRepository>();

  @override
  void onInit() async {
    super.onInit();
    initThemeAndLocalization();
  }

  initThemeAndLocalization() async {
    isDarkTheme = await repository.getThemeMode() ?? false;
    CustomColor.switchTheme(!isDarkTheme);
    currentLocale = await setLocale();
    update();
  }

  Future<Locale> setLocale() async {
    String languageCode = await repository.getLocalization() ?? 'en';
    return Locale(languageCode);
  }

  void logout() async {
    await authRepository.logOut();
    Get.offAllNamed(RouteName.loginScreen);
  }

  void switchTheme() async {
    CustomColor.switchTheme(isDarkTheme);
    isDarkTheme = !isDarkTheme;
    await repository.changeThemeMode(isDarkTheme);
    update();
  }

  void switchLocalization(Language language) async {
    Locale? locale;
    String? languageCode;
    if(language == Language.indonesian) {
      languageCode = 'id';
    } else {
      languageCode = 'en';
    }
    locale = Locale(languageCode);
    Get.updateLocale(locale);
    await repository.changeLocalization(languageCode);
  }


}