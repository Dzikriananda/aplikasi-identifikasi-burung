import 'package:bird_guard/src/core/localization/app_localization.dart';
import 'package:bird_guard/src/core/styles/theme.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/local/local_storage/local_storage.dart';
import 'package:bird_guard/src/data/model/history_cache/history_cache.dart';
import 'package:bird_guard/src/data/model/species_list_cache/species_list_cache.dart';
import 'package:bird_guard/src/data/model/user_model/user_model.dart';
import 'package:bird_guard/src/route/app_route.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:bird_guard/src/viewmodel/system_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await initHive();
  setupLocator();
  await locator<LocalStorage>().init();
  Get.put(SystemController(), permanent: true);
  runApp(const MyApp());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(SpeciesListCacheAdapter());
  Hive.registerAdapter(HistoryCacheAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return GetBuilder<SystemController>(
          builder: (_) {
            return GetMaterialApp(
              theme: const MaterialTheme(TextTheme()).light(),
              darkTheme: const MaterialTheme(TextTheme()).dark(),
              themeMode: Get.find<SystemController>().isDarkTheme ? ThemeMode.dark : ThemeMode.light,
              initialRoute: RouteName.splashScreen,
              getPages: AppRoute.getRoute(),
              translations: AppLocalizations(),
              locale: Get.find<SystemController>().currentLocale,
              fallbackLocale: Locale('en','US'),
            );
          },
        );
      }
    );
  }
}
