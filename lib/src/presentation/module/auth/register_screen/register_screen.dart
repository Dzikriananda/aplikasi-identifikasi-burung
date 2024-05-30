import 'package:bird_guard/src/core/gen/assets.gen.dart';
import 'package:bird_guard/src/core/util/util.dart';
import 'package:bird_guard/src/presentation/module/auth/login_screen/widget/login_padding.dart';
import 'package:bird_guard/src/presentation/module/auth/register_screen/widget/first_form.dart';
import 'package:bird_guard/src/presentation/module/auth/register_screen/widget/second_form.dart';
import 'package:bird_guard/src/presentation/module/global_widget/align_left.dart';
import 'package:bird_guard/src/route/app_route.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:bird_guard/src/viewmodel/register_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../core/classes/enum.dart';

typedef MyBuilder = void Function(BuildContext context, bool Function() methodFromChild);

class RegisterScreen extends GetView<RegisterScreenViewModel> {
  RegisterScreen({super.key});



  final GlobalKey<FormState> firstFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> secondFormKey = GlobalKey<FormState>();



  listenForEventDialog() {
    ever(controller.status, (status) {
      Helper.listenForEvent(
        true,
        status,
        controller.response.value?.message,
        () => controller.status.value = Status.idle,
        () => controller.status.value = Status.idle,
        () => Get.back()
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    listenForEventDialog();
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Obx(
                  () => Center(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                        Image.asset(Assets.images.logoNoBackground.path,height: 85),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                        LoginPadding(
                          body: AlignLeft(
                            body: Text(
                              'register_1'.tr,
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: (controller.isIdle.value || !controller.isMoving.value) ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: Builder(
                              builder: (context) {
                                switch(controller.currentPage.value) {
                                  case 0 : return FirstForm(formkey: firstFormKey);
                                  case 1 : return SecondForm(formkey: secondFormKey);
                                  default : return const SizedBox();
                                }
                              }
                          ),
                        ),
                        Visibility(
                          visible: !controller.isPasswordMatched.value,
                          child:  Text(
                              'Both password doesnt match',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.red
                              )
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if(controller.currentPage.value == 0) {
                              if(firstFormKey.currentState!.validate()) {
                                controller.forwardForm();
                              }
                            } else {
                              controller.backForm();
                            }
                          },
                          icon: (controller.currentPage.value == 0) ? Icon(Icons.arrow_circle_right_outlined,size: 50)
                              : Icon(Icons.arrow_circle_left_outlined,size: 50)
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                          child:  AnimatedOpacity(
                            opacity: (controller.currentPage == 1) ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 500),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if(secondFormKey.currentState!.validate()) {
                                    controller.checkPasswordValue();
                                    if(controller.isPasswordMatched.value) {
                                      controller.register();
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    minimumSize: Size.fromHeight(50)
                                ),
                                child: Text('register_5'.tr,style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ))
                            ),
                          )
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Text(
                                  'register_6'.tr,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 5.w),
                              ),
                              WidgetSpan(
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Text(
                                        'register_7'.tr,
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                            color: Theme.of(context).primaryColor
                                        )
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              )
            )
        )
    );
  }
}

