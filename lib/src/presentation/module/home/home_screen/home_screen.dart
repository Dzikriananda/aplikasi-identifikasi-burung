import 'package:bird_guard/src/core/constant/image.dart';
import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/presentation/module/global_widget/profile_avatar.dart';
import 'package:bird_guard/src/presentation/module/home/home_screen/widget/home_screen_padding.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:bird_guard/src/viewmodel/home_viewmodel.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeViewModel(),
      builder: (viewModel) {
        return Center(
          child: Column(
            children: [
              HomeScreenPadding(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileAvatar(name: viewModel.userData?.name ?? '...'),
                      SizedBox(width: 10.w),
                      Text(
                        viewModel.userData?.name ?? '',
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
                    return const SizedBox(height: 0,width: 15);
                  },
                  padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: AppImage.images[index],
                    );
                  },

                ),
              ),
              const SizedBox(height: 15),
              HomeScreenPadding(
                  child:  InkWell(
                    onTap: () async {
                      List<CameraDescription> cameras = await availableCameras();
                      Get.toNamed(RouteName.cameraScreen,arguments: cameras);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                      height: 80.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CustomColor.historyItemColor,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.35),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.camera_alt_rounded,size: 45,color: Colors.purple),
                          const SizedBox(width: 15),
                          Text('home_item_1'.tr,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp
                          )),
                        ],
                      ),
                    ),
                  )
              ),
              const SizedBox(height: 20),
              HomeScreenPadding(
                  child: InkWell(
                    onTap: () => Get.toNamed(RouteName.birdSpeciesListScreen),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                      height: 80.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CustomColor.historyItemColor,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.35),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.menu_book_sharp,size: 45,color: Colors.purple),
                          const SizedBox(width: 15),
                          Text('home_item_2'.tr,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp
                          )),
                          // Expanded(child: Assets.images.home1.image())
                        ],
                      ),
                    ),
                  )
              ),
              const SizedBox(height: 20),
              HomeScreenPadding(
                  child:  InkWell(
                    onTap: () async {
                      Get.toNamed(RouteName.historyScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                      height: 80.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CustomColor.historyItemColor,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.35),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.history,size: 45,color: Colors.purple),
                          const SizedBox(width: 15),
                          Text('home_item_3'.tr,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp
                          )),
                          // Expanded(child: Assets.images.home1.image())
                        ],
                      ),
                    ),
                  )
              ),
              const SizedBox(
                height: 200,
              )
            ],
          ),
        );
      }
    );
  }
}
