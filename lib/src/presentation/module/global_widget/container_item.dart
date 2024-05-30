import 'dart:io';

import 'package:bird_guard/src/core/gen/assets.gen.dart';
import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerItem extends StatelessWidget {
  const ContainerItem({super.key,required this.imagePath,required this.title});

  final String imagePath;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
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
      height: 155.h,
      width: 155.w,
      child: Column(
        children: [
          Container(
            height: 120.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.file(
                  File(imagePath),
                ),
              ),
            )
          ),
          Expanded(
              child: Container(
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}
