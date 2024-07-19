import 'package:bird_guard/src/core/util/string_util.dart';
import 'package:bird_guard/src/data/model/user_model/user_model.dart';
import 'package:bird_guard/src/presentation/module/global_widget/profile_avatar.dart';
import 'package:bird_guard/src/presentation/module/home/profile_screen/widget/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  late UserModel data;

  @override
  Widget build(BuildContext context) {
    data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileAvatar(name: data.name!),
                  SizedBox(height: 10.h),
                  Text(
                    data.name!,
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                ],
              ),
              SizedBox(height: 45),
              ProfileItem(
                icon: Icon(Icons.person,size: 35),
                profileItemName: 'Name',
                profileData: data.name!,
              ),
              ProfileItem(
                icon: Icon(Icons.email,size: 35),
                profileItemName: 'Email',
                profileData: data.email!,
              ),
              ProfileItem(
                icon: Icon(Icons.person,size: 35),
                profileItemName: 'Username',
                profileData: data.username!,
              ),
              ProfileItem(
                  icon: Icon(Icons.date_range,size: 35),
                  profileItemName: 'Account Created',
                  profileData: StringUtil.dateFormat(data.createdAt!)
              ),
              ProfileItem(
                  icon: Icon(Icons.phone,size: 35),
                  profileItemName: 'Phone Number',
                  profileData: data.phone!
              ),
            ],
          ),
        ),
      )
    );
  }
}
