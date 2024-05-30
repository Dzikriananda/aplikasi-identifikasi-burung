import 'dart:io';

import 'package:bird_guard/src/core/constant/image.dart';
import 'package:bird_guard/src/core/gen/assets.gen.dart';
import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/presentation/module/global_widget/profile_avatar.dart';
import 'package:bird_guard/src/presentation/module/home/home_screen/widget/home_screen_padding.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const String name = 'Dzikri Ananda';

  Future<void> deleteDir() async {
    List<FileSystemEntity>? _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/images';
    final myDir = Directory(pdfDirectory);
    await myDir.delete(recursive: true);
    // print('daftar isi : ${_folders[2]}');
    // _folders.forEach((FileSystemEntity entity) {
    //   if (entity is File) {
    //     entity.lengthSync();
    //   }
    // });
  }

  Future<void> getDir() async {
    List<FileSystemEntity>? _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/images';
    final myDir = new Directory(pdfDirectory);
    _folders = myDir.listSync(recursive: true, followLinks: false);
    var dirSize = _folders.fold(0, (int sum, file) => sum + file.statSync().size);
    print('isi folder $_folders');

    // print('daftar isi : ${_folders[2]}');
    // _folders.forEach((FileSystemEntity entity) {
    //   if (entity is File) {
    //     entity.lengthSync();
    //   }
    // });
  }

  // Future<void> getDir() async {
  //   List<FileSystemEntity>? _folders;
  //   final directory = await getApplicationDocumentsDirectory();
  //   final dir = directory.path;
  //   String pdfDirectory = '$dir';
  //   final myDir = new Directory(pdfDirectory);
  //   _folders = myDir.listSync(recursive: true, followLinks: false);
  //   var dirSize = _folders.fold(0, (int sum, file) => sum + file.statSync().size);
  //   print('isi folder $_folders');
  //
  //   // print('daftar isi : ${_folders[2]}');
  //   // _folders.forEach((FileSystemEntity entity) {
  //   //   if (entity is File) {
  //   //     entity.lengthSync();
  //   //   }
  //   // });
  // }

  Future<void> createDir() async {
    List<FileSystemEntity>? _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/images';
    final myDir = new Directory(pdfDirectory);
    if (!await myDir.exists()) {
      await myDir.create(recursive: true);
    }
    _folders = myDir.listSync(recursive: true, followLinks: false);
    print('daftar isi : $_folders');
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          HomeScreenPadding(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileAvatar(name: name),
                  SizedBox(width: 10.w),
                  Text(
                    'Dzikri Ananda',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            height: 188.h,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 0,width: 15);
              },
              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20.w),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: AppImage.images[index],
                );
              },

            ),
          ),
          SizedBox(height: 15),
          HomeScreenPadding(
            child:  InkWell(
              onTap: () async {
                List<CameraDescription> cameras = await availableCameras();
                Get.toNamed(RouteName.cameraScreen,arguments: cameras);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColor.historyItemColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.35),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.camera_alt_rounded,size: 45,color: Colors.purple),
                    SizedBox(width: 15),
                    Text('Identify',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp
                    )),
                    // Expanded(child: Assets.images.home1.image())
                  ],
                ),
              ),
            )
          ),
          SizedBox(height: 20),
          HomeScreenPadding(
            child: InkWell(
              onTap: () => Get.toNamed(RouteName.birdSpeciesListScreen),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColor.historyItemColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.35),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu_book_sharp,size: 45,color: Colors.purple),
                    SizedBox(width: 15),
                    Text('Bird species list',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp
                    )),
                    // Expanded(child: Assets.images.home1.image())
                  ],
                ),
              ),
            )
          ),
          SizedBox(height: 20),
          HomeScreenPadding(
            child:  InkWell(
              onTap: () async {
                Get.toNamed(RouteName.historyScreen);
                // final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
                // print(appDocumentsDir.path);
                // getDir();
                // createDir();
                // deleteDir();

                // Get.defaultDialog(
                //   title: "Feature Not Ready",
                //   middleText: "This feature is still in development and is not yet ready",
                //   middleTextStyle: Theme.of(context).textTheme.bodyLarge,
                //   textConfirm: "OK",
                //   buttonColor: Theme.of(context).colorScheme.primary,
                //   onConfirm: () => Get.back()
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColor.historyItemColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.35),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.history,size: 45,color: Colors.purple),
                    SizedBox(width: 15),
                    Text('History',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp
                    )),
                    // Expanded(child: Assets.images.home1.image())
                  ],
                ),
              ),
            )
          ),
          // Image.network('https://picsum.photos/250?image=9'),
          // HomeScreenPadding(
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       'Recently Scanned',
          //       style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 22.sp
          //       ),
          //     )
          //   ),
          // ),
          // SizedBox(height: 15),
          // HomeScreenPadding(
          //   child:  Container(
          //     height: 100.h,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       color: CustomColor.historyItemColor,
          //       borderRadius: BorderRadius.all(Radius.circular(15)),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.withOpacity(0.35),
          //           spreadRadius: 5,
          //           blurRadius: 7,
          //           offset: Offset(0, 3), // changes position of shadow
          //         ),
          //       ],
          //     ),
          //     child: Row(
          //       children: [
          //         Icon(Icons.menu_book_sharp),
          //         SizedBox(width: 15),
          //         Text('Available species,')
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(height: 15),
          // SizedBox(
          //   height: (120.h * 5) + (40.h),
          //   child: ListView.separated(
          //     separatorBuilder: (BuildContext context, int index) {
          //       return SizedBox(height: 15.h,width: 0);
          //     },
          //     padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20.h),
          //     itemCount: 5,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemBuilder: (BuildContext context, int index) {
          //       return Container(
          //         height: 100.h,
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           color: CustomColor.historyItemColor,
          //           borderRadius: BorderRadius.all(Radius.circular(15)),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.35),
          //               spreadRadius: 5,
          //               blurRadius: 7,
          //               offset: Offset(0, 3), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
          SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
