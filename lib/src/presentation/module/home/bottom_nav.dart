import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/presentation/module/home/home_screen/home_screen.dart';
import 'package:bird_guard/src/presentation/module/home/settings_screen/settings_screen.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:bird_guard/src/viewmodel/system_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  List<Widget> bodyWidget = [
    HomeScreen(),
    SettingsScreen(),
  ];

  Color? getButtonColor(int index) {
    if(index == currentIndex) return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemController>(
      builder: (_) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: CustomColor.surfaceContainer,
            ),
            automaticallyImplyLeading: false,
            toolbarHeight: 25.h,
          ),
          body: SingleChildScrollView(
            child: bodyWidget[currentIndex],
          ),
          floatingActionButton: SizedBox(
            width: 60.w,
            child: FittedBox(
              child:  FloatingActionButton(
                onPressed: () async {
                  List<CameraDescription> cameras = await availableCameras();
                  Get.toNamed(RouteName.cameraScreen,arguments: cameras);
                },
                tooltip: 'Increment',
                child: Icon(Icons.camera_alt_rounded),
                elevation: 3.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: CustomColor.surfaceContainer,
            elevation: 0,
            shape: CircularNotchedRectangle(),
            notchMargin: 10.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home,size: 40),
                  color: getButtonColor(0),
                  onPressed: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                ),
                SizedBox(width: 48.w), // The dummy child for the notch
                IconButton(
                  icon: Icon(Icons.settings,size: 40),
                  color: getButtonColor(1),
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
