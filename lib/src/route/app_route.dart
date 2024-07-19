

import 'package:bird_guard/src/core/binding/bird_detail_screen_binding.dart';
import 'package:bird_guard/src/core/binding/bird_species_list_screen_binding.dart';
import 'package:bird_guard/src/core/binding/camera_screen_binding.dart';
import 'package:bird_guard/src/core/binding/detail_screen_binding.dart';
import 'package:bird_guard/src/core/binding/history_screen_binding.dart';
import 'package:bird_guard/src/core/binding/login_screen_binding.dart';
import 'package:bird_guard/src/core/binding/register_screen_binding.dart';
import 'package:bird_guard/src/core/binding/splash_screen_binding.dart';
import 'package:bird_guard/src/presentation/module/auth/login_screen/login_screen.dart';
import 'package:bird_guard/src/presentation/module/auth/register_screen/register_screen.dart';
import 'package:bird_guard/src/presentation/module/auth/splash_screen/splash_screen.dart';
import 'package:bird_guard/src/presentation/module/detect/camera_screen/camera_screen.dart';
import 'package:bird_guard/src/presentation/module/detect/detail_screen/detail_screen.dart';
import 'package:bird_guard/src/presentation/module/home/bird_species_detail_screen/bird_species_detail_screen.dart';
import 'package:bird_guard/src/presentation/module/home/bird_species_list_screen/bird_species_list_screen.dart';
import 'package:bird_guard/src/presentation/module/home/bottom_nav.dart';
import 'package:bird_guard/src/presentation/module/home/history_detail_screen/history_detail_screen.dart';
import 'package:bird_guard/src/presentation/module/home/history_screen/history_screen.dart';
import 'package:bird_guard/src/presentation/module/home/profile_screen/profile_screen.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoute {
  static getRoute() {
    return [
      GetPage(name: RouteName.splashScreen, page: () => SplashScreen(),binding: SplashScreenBinding()),
      GetPage(
          name: RouteName.loginScreen,
          page: () => LoginScreen(),
          binding: LoginScreenBinding(),
          transitionDuration: Duration(seconds: 2),
          transition: Transition.fadeIn
      ),
      GetPage(
          name: RouteName.mainScreen,
          page: () => BottomNavBar(),
          transitionDuration: Duration(seconds: 1),
          transition: Transition.fadeIn
      ),
      GetPage(
          name: RouteName.cameraScreen,
          page: () => CameraScreen(),
          binding: CameraScreenBinding(),
          transitionDuration: Duration(seconds: 1),
          transition: Transition.fadeIn
      ),
      GetPage(
          name: RouteName.registerScreen,
          page: () => RegisterScreen(),
          binding: RegisterScreenBinding(),
          transitionDuration: Duration(seconds: 1),
          transition: Transition.fadeIn
      ),
      GetPage(
          name: RouteName.detailScreen,
          page: () => DetailScreen(),
          binding: DetailScreenBinding(),
          transitionDuration: Duration(seconds: 1),
          transition: Transition.fadeIn
      ),
      GetPage(
          name: RouteName.birdSpeciesListScreen,
          page: () => BirdSpeciesListScreen(),
          binding: BirdSpeciesListScreenBinding(),
          // transitionDuration: Duration(seconds: 1),
          // transition: Transition.fadeIn
      ),
      GetPage(
        name: RouteName.historyScreen,
        page: () => HistoryScreen(),
        binding: HistoryScreenBinding()
        // transitionDuration: Duration(seconds: 1),
        // transition: Transition.fadeIn
      ),
      GetPage(
          name: RouteName.historyDetailScreen,
          page: () => HistoryDetailScreen(),
          // binding: HistoryScreenBinding()
        // transitionDuration: Duration(seconds: 1),
        // transition: Transition.fadeIn
      ),
      GetPage(
        name: RouteName.birdSpeciesListDetailScreen,
        page: () => BirdSpeciesDetailScreen(),
        binding: BirdDetailScreenBinding()
      ),
      GetPage(
        name: RouteName.profileScreen,
        page: () => ProfileScreen(),
      ),
    ];
  }

}