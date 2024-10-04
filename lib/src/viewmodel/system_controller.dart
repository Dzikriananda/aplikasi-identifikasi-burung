import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/core/util/file_manager.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/local/local_storage/local_storage.dart';
import 'package:bird_guard/src/data/model/device_info.dart';
import 'package:bird_guard/src/data/model/user_model/user_model.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:bird_guard/src/data/repository/system_repository.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SystemController extends GetxController {

  late bool isDarkTheme;
  late Locale currentLocale;
  SystemRepository repository = locator<SystemRepository>();
  AuthRepository authRepository = locator<AuthRepository>();
  UserModel? userData;
  FileManager fileManager = FileManager();
  late DeviceInfo info;
  late double sliderValue;

  @override
  void onInit() {
    super.onInit();
    initThemeAndLocalization();
    initImageCompressionLevel();
    getUserData();
    info = DeviceInfo(
      availableStorage: 0,
      appCacheSize: 0,
      totalStorage: 0
    );
  }

  initThemeAndLocalization() async {
    isDarkTheme = await repository.getThemeMode() ?? false;
    CustomColor.switchTheme(!isDarkTheme);
    currentLocale = await setLocale();
    update();
  }

  initImageCompressionLevel() async {
    int? imgCompressionLevel = await repository.getImageCompressionLevel();
    if(imgCompressionLevel == null) {
      sliderValue = 35;
      await repository.saveImageCompressionLevel(35);
    } else {
      sliderValue = imgCompressionLevel.toDouble();
    }
  }
  
  setImageCompressionLevel() async {
    await repository.saveImageCompressionLevel(sliderValue.round());
  }

  Future<Locale> setLocale() async {
    String languageCode = await repository.getLocalization() ?? 'en';
    return Locale(languageCode);
  }

  void logout() async {
    sliderValue = 35;
    await clearCache();
    await authRepository.logOut();
    Get.offAllNamed(RouteName.loginScreen);
  }

  Future<void> clearCache() async {
    await fileManager.deleteDir();
    await repository.deleteCache();
    await repository.reOpenDatabase();
    info.appCacheSize = 0.0;
    update();

  }

  Future<UserModel?> getUserData() async {
    UserModel? data = await authRepository.getLocalUserData();
    userData = data;
    update();
    return data;
  }

  void switchTheme() async {
    CustomColor.switchTheme(isDarkTheme);
    isDarkTheme = !isDarkTheme;
    await repository.changeThemeMode(isDarkTheme);
    update();
  }

  void getStorageInfo() async {
    const MethodChannel channel = MethodChannel('com.dzikriananda.birdguard/channel');
    try {
      var res = await channel.invokeMethod('getStorageInfo');
      var cacheSize = await fileManager.getImageCacheSize();
      info = DeviceInfo(
        appCacheSize: cacheSize,
        availableStorage: res['availableStorage'],
        totalStorage: res['totalStorage']
      );
    } on PlatformException catch (e) {
      print(e);
    }
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