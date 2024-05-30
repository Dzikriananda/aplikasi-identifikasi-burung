import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/presentation/module/global_widget/profile_avatar.dart';
import 'package:bird_guard/src/presentation/module/home/settings_screen/widget/setting_item.dart';
import 'package:bird_guard/src/presentation/module/home/settings_screen/widget/setting_padding.dart';
import 'package:bird_guard/src/viewmodel/system_controller.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String name = 'Dzikri Ananda';

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SystemController(),
      builder: (controller) {
        return Center(
          child: Column(
            children: [
              Container(
                child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProfileAvatar(name: name),
                    SizedBox(height: 10.h),
                    Text(
                      'Dzikri Ananda',
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              // SettingPadding(
              //   child: SettingItem(
              //     title: 'settingItem_1'.tr,
              //     prefixIcon: Icon(Icons.person,size: 30),
              //     onTap: () {},
              //   ),
              // ),
              SettingPadding(
                child: SettingItem(
                  title: 'Logout',
                  prefixIcon: Icon(Icons.logout,size: 30),
                  onTap: () {
                    Get.defaultDialog(
                        title: 'Logout',
                        middleText: 'Are you sure you want to logout?',
                        textConfirm: 'Logout',
                        buttonColor: Theme.of(context).colorScheme.primary,
                        textCancel: 'Cancel',
                        onConfirm: () {
                          controller.logout();
                        }
                    );
                  },
                ),
              ),
              SettingPadding(
                child: SettingItem(
                  title: 'settingItem_2'.tr,
                  prefixIcon: Icon(Icons.nightlight,size: 30),
                  onTap: () {},
                  suffixIcon:  Switch(
                    value: controller.isDarkTheme,
                    onChanged: (value) {
                      controller.switchTheme();
                    },
                  ),
                ),
              ),
              SettingPadding(
                child: SettingItem(
                  title: 'settingItem_3'.tr,
                  prefixIcon: Icon(Icons.language,size: 30),
                  onTap: () {
                    Get.defaultDialog(
                        title: 'Choose a Language',
                        // textConfirm: "OK",
                        content: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.switchLocalization(Language.indonesian);
                              },
                              icon: Flag.fromCode(
                                FlagsCode.ID,
                                height: 30,
                                width: 40,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(height: 15),
                            IconButton(
                              onPressed: () {
                                controller.switchLocalization(Language.english);
                              },
                              icon: Flag.fromCode(
                                FlagsCode.US,
                                height: 30,
                                width: 40,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        confirmTextColor: Colors.amberAccent,
                        barrierDismissible: false,
                        textCancel: 'Close');
                  },
                ),
              ),
              // SettingPadding(
              //   child: SettingItem(
              //     title: 'settingItem_4'.tr,
              //     prefixIcon: Icon(Icons.headphones,size: 30),
              //     onTap: () {},
              //   ),
              // ),
              SettingPadding(
                child: SettingItem(
                  title: 'Storage'.tr,
                  prefixIcon: Icon(Icons.storage,size: 30),
                  onTap: () {

                  },
                ),
              ),
              // SettingPadding(
              //   child: SettingItem(
              //     title: 'settingItem_5'.tr,
              //     prefixIcon: Icon(Icons.question_answer_outlined,size: 30),
              //     onTap: () {},
              //   ),
              // ),
              SettingPadding(
                child: SettingItem(
                  title: 'settingItem_6'.tr,
                  prefixIcon: Icon(Icons.question_mark,size: 30),
                  onTap: () {},
                ),
              ),
              SizedBox(height: 150.h)
            ],
          ),
        );
      }
    );
  }
}
