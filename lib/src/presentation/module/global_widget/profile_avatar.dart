import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key,required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 30.h,
          backgroundColor: Colors.grey,
        ),
        Text(name[0] ,style: Theme.of(context).textTheme.headlineLarge,)
      ],
    );
  }
}
