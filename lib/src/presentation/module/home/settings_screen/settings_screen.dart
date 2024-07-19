import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/gen/assets.gen.dart';
import 'package:bird_guard/src/core/util/file_manager.dart';
import 'package:bird_guard/src/data/model/user_model/user_model.dart';
import 'package:bird_guard/src/presentation/module/global_widget/primary_button.dart';
import 'package:bird_guard/src/presentation/module/global_widget/profile_avatar.dart';
import 'package:bird_guard/src/presentation/module/home/settings_screen/widget/setting_item.dart';
import 'package:bird_guard/src/presentation/module/home/settings_screen/widget/setting_padding.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:bird_guard/src/viewmodel/system_controller.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SystemController(),
      builder: (controller) {
        controller.getUserData();
        return Center(
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileAvatar(name: controller.userData?.name ?? '...'),
                  SizedBox(height: 10.h),
                  Text(
                    controller.userData?.name ?? '',
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                ],
              ),
              SizedBox(height: 30.h),
              SettingPadding(
                child: SettingItem(
                  title: 'settingItem_7'.tr,
                  prefixIcon: Icon(Icons.logout,size: 30),
                  onTap: () {
                    Get.defaultDialog(
                        title: 'settingItem_7'.tr,
                        middleText: 'settingItem_7_dialog_middleText'.tr,
                        textConfirm: 'settingItem_7_dialog_textConfirm'.tr,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        textCancel: 'dialog_cancel_1'.tr,
                        onConfirm: () {
                          controller.logout();
                        }
                    );
                  },
                ),
              ),
              SettingPadding(
                child: SettingItem(
                  title: 'settingItem_1'.tr,
                  prefixIcon: Icon(Icons.person,size: 30),
                  onTap: () async {
                    UserModel? data = await controller.getUserData();
                    Get.toNamed(RouteName.profileScreen,arguments: data);

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
                        title: 'settingItem_3_dialog_middleText'.tr,
                        // textConfirm: "OK",
                        content: Column(
                          children: [
                            Row(
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
                                Text('Bahasa Indonesia')
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
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
                                Text('English')
                              ],
                            )
                          ],
                        ),
                        cancel: PrimaryButton(
                          onPressed: () => Get.back(),
                          title: 'OK',
                        ),
                        barrierDismissible: false,
                    );
                  },
                ),
              ),
              SettingPadding(
                child: SettingItem(
                  title: 'settingItem_6'.tr,
                  prefixIcon: Icon(Icons.question_mark,size: 30),
                  onTap: () {
                    Get.defaultDialog(
                      title: "",
                      content: Column(
                        children: [
                          Assets.images.logoNoBackground.image(),
                          Text('Version 1.0.0'),
                          SizedBox(height: 15),
                          Text('An app that created to help people to prevent protected bird from being abused'),
                          SizedBox(height: 15),
                          Text('An app that created to help people to prevent protected bird from being abused'),
                          SizedBox(height: 15),
                          PrimaryButton(
                            onPressed: () => Get.back(),
                            title: 'Close',
                          )

                        ],
                      )
                    );
                  },
                ),
              ),
              SettingPadding(
                child: SettingItem(
                  title: 'Cache Storage'.tr,
                  prefixIcon: Icon(Icons.storage,size: 30),
                  onTap: () {
                    FileManager().getDirContent();
                  },
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
