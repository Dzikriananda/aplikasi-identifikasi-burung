import 'package:bird_guard/src/core/gen/assets.gen.dart';
import 'package:bird_guard/src/core/util/util.dart';
import 'package:bird_guard/src/presentation/module/global_widget/custom_dialog.dart';
import 'package:bird_guard/src/presentation/module/auth/login_screen/widget/hide_password_widget.dart';
import 'package:bird_guard/src/presentation/module/auth/login_screen/widget/login_padding.dart';
import 'package:bird_guard/src/presentation/module/global_widget/align_left.dart';
import 'package:bird_guard/src/presentation/module/global_widget/app_form_field.dart';
import 'package:bird_guard/src/presentation/module/global_widget/form_title.dart';
import 'package:bird_guard/src/presentation/module/global_widget/stateful_handle_widget.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:bird_guard/src/viewmodel/login_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../core/classes/enum.dart';
import 'package:bird_guard/src/core/util/extension.dart';

class LoginScreen extends GetView<LoginScreenViewModel> {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  late void Function() hidePassword;


  listenForEventDialog() {
    ever(controller.status, (status) {
      Helper.listenForEvent(
          false,
          status,
          controller.response.value?.message,
              () => controller.status.value = Status.idle,
              () => controller.status.value = Status.idle,
              null
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    listenForEventDialog();
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Hero(
                    tag: "logo",
                    child: Image.asset(Assets.images.logoNoBackground.path,height: 70.h)
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  LoginPadding(
                    body: AlignLeft(
                      body: Text(
                        'login_1'.tr,
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding : EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: FormTitle(title: 'formTitle_1'.tr)
                          ),
                        ),
                        LoginPadding(
                          body: AppFormField(
                            hintText: 'formHint_1'.tr,
                            validator: (val) {
                              if (!val!.isNotNull) return 'formWarning_1'.tr;
                              return null;
                            },
                            suffixIcon: Icon(Icons.email),
                            onChanged: (value) {
                              controller.enterIdentifier(value);
                            },
                          ),
                        ),
                        Padding(
                          padding : EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: FormTitle(title: 'formTitle_2'.tr)
                          ),
                        ),
                        LoginPadding(
                          body: AppFormField(
                            hintText: 'formHint_2'.tr,
                            obscureText: true,
                            method: (BuildContext context, void Function() method) {
                              hidePassword = method;
                            },
                            validator: (val) {
                              if (!val!.isNotNull) return 'formWarning_1'.tr;
                              return null;
                            },
                            suffixIcon: HidePasswordButton(
                              function: () {
                                hidePassword();
                              },
                            ),
                            onChanged: (value) {
                              controller.enterPassword(value);
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 60, 30, 10),
                    child:  ElevatedButton(
                        onPressed: () async {
                          // Get.toNamed(RouteName.mainScreen);
                          if(_formKey.currentState!.validate()) {
                            // Get.toNamed(RouteName.mainScreen);
                            controller.login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size.fromHeight(45.h)
                        ),
                        child: Text('login_4'.tr,style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                        ))
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Text(
                            'login_5'.tr,
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
                                Get.toNamed(RouteName.registerScreen);
                              },
                              child: Text(
                                  'login_6'.tr,
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
    );
  }
}

