import 'package:bird_guard/src/core/util/extension.dart';
import 'package:bird_guard/src/presentation/module/auth/register_screen/register_screen.dart';
import 'package:bird_guard/src/presentation/module/global_widget/form_title.dart';
import 'package:bird_guard/src/viewmodel/register_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widget/app_form_field.dart';
import '../../login_screen/widget/login_padding.dart';

class FirstForm extends GetView<RegisterScreenViewModel> {
  FirstForm({super.key,required this.formkey});
  final GlobalKey<FormState> formkey;

  // final TextEditingController _firstController = TextEditingController();
  // final TextEditingController _secondController = TextEditingController();
  // final TextEditingController _thirdcontroller = TextEditingController();


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
              child: FormTitle(title: 'formTitle_3'.tr),
            ),
          ),
          LoginPadding(
            body: AppFormField(
              hintText: 'formHint_3'.tr,
              initialValue: controller.getEmailInitialValue(),
              suffixIcon: Icon(Icons.email),
              validator: (val) {
                if (!val!.isNotNull) return 'formWarning_1'.tr;
                if (!val.isValidEmail) return 'formWarning_2'.tr;
                return null;
              },
              onChanged: (value) {
                controller.enterEmail(value);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
            child:  Align(
              alignment: Alignment.centerLeft,
              child: FormTitle(title: 'formTitle_4'.tr),
            ),
          ),
          LoginPadding(
            body: AppFormField(
              hintText: 'formHint_4'.tr,
              initialValue: controller.getUsernameInitialValue(),
              validator: (val) {
                if (!val!.isNotNull) return 'formWarning_1'.tr;
                return null;
              },
              suffixIcon: Icon(Icons.account_circle_sharp),
              onChanged: (value) {
                controller.enterUsername(value);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
            child:  Align(
              alignment: Alignment.centerLeft,
              child: FormTitle(title: 'formTitle_5'.tr),
            ),
          ),
          LoginPadding(
            body: AppFormField(
              hintText: 'formHint_5'.tr,
              initialValue: controller.getFullnameInitialValue(),
              validator: (val) {
                if (!val!.isNotNull) return 'formWarning_1'.tr;
                return null;
              },
              suffixIcon: Icon(Icons.account_circle_sharp),
              onChanged: (value) {
                controller.enterName(value);
              },
            ),
          ),
        ],
      )
    );
  }
}
