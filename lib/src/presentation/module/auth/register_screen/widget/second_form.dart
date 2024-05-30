import 'package:bird_guard/src/core/util/extension.dart';
import 'package:bird_guard/src/presentation/module/auth/register_screen/register_screen.dart';
import 'package:bird_guard/src/presentation/module/global_widget/form_title.dart';
import 'package:bird_guard/src/viewmodel/register_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widget/app_form_field.dart';
import '../../login_screen/widget/hide_password_widget.dart';
import '../../login_screen/widget/login_padding.dart';

class SecondForm extends GetView<RegisterScreenViewModel> {
  SecondForm({super.key,required this.formkey});
  final GlobalKey<FormState> formkey;
  late void Function() hideFirstPassword;
  late void Function() hideSecondPassword;



  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: FormTitle(title: 'formTitle_6'.tr),
              ),
            ),
            LoginPadding(
              body: AppFormField(
                hintText: 'formHint_6'.tr,
                validator: (val) {
                  if (!val!.isNotNull) return 'formWarning_1'.tr;
                  else if (!val.isValidPhone) return 'formWarning_3'.tr;
                  return null;
                },
                suffixIcon: Icon(Icons.call),
                onChanged: (value) {
                  controller.enterPhoneNumber(value);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: FormTitle(title: 'formTitle_2'.tr),
              ),
            ),
            LoginPadding(
              body: AppFormField(
                hintText: 'formHint_7'.tr,
                validator: (val) {
                  if (!val!.isNotNull) return 'formWarning_1'.tr;
                  else if (!val.isValidPassword) return 'formWarning_4'.tr;
                  return null;
                },
                obscureText: true,
                method: (BuildContext context, void Function() method) {
                  hideFirstPassword = method;
                },
                suffixIcon: HidePasswordButton(
                  function: () {
                    hideFirstPassword();
                  },
                ),
                onChanged: (value) {
                  controller.enterFirstPassword(value);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: FormTitle(title: 'formTitle_2'.tr),
              ),
            ),
            LoginPadding(
              body: AppFormField(
                hintText: 'formHint_8'.tr,
                validator: (val) {
                  if (!val!.isNotNull) return 'formWarning_1'.tr;
                  else if (!val.isValidPassword) return 'formWarning_4'.tr;
                  return null;
                },
                obscureText: true,
                method: (BuildContext context, void Function() method) {
                  hideSecondPassword = method;
                },
                suffixIcon: HidePasswordButton(
                  function: () {
                    hideSecondPassword();
                  },
                ),
                onChanged: (value) {
                  controller.enterSecondPassword(value);
                },
              ),
            ),
          ],
        )
    );
  }
}
