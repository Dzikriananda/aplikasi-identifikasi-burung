import 'dart:io';

import 'package:bird_guard/src/core/constant/image.dart';
import 'package:bird_guard/src/core/gen/assets.gen.dart';
import 'package:bird_guard/src/presentation/module/detect/detail_screen/widget/detail_padding.dart';
import 'package:bird_guard/src/viewmodel/detail_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailScreen extends GetView<DetailScreenViewModel> {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Scaffold(
            appBar: AppBar(
              title: Text('11/03/2024 11:23'),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: FileImage(File(controller.imagePath)),
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  SizedBox(height: 15),
                  DetailPadding(
                      child:  Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.predictResult.value![2]!.keys!.first!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 22.sp
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 5),
                  DetailPadding(
                      child: Row(
                        children: [
                          Text(
                            'Accuracy :',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp
                            ),
                          ),
                          Spacer(),
                          CircularPercentIndicator(
                            radius: 45.0,
                            lineWidth: 10.0,
                            percent: controller.predictResult.value![2]!.values!.first!/100,
                            center: Text("${controller.predictResult.value![2]!.values!.first!}%"),
                            progressColor: Colors.green,
                          )
                        ],
                      )
                  ),
                  SizedBox(height: 5),
                  DetailPadding(
                      child:  Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.predictResult.value![1]!.keys!.first!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp
                          ),
                        ),
                      )
                  ),
                  DetailPadding(
                      child: Row(
                        children: [
                          Text(
                            'Accuracy :',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp
                            ),
                          ),
                          Spacer(),
                          CircularPercentIndicator(
                            radius: 39.0,
                            lineWidth: 8.0,
                            percent: controller.predictResult.value![1]!.values!.first!/100,
                            center: Text("${controller.predictResult.value![1]!.values!.first!}%"),
                            progressColor: Colors.green,
                          )
                        ],
                      )
                  ),
                  SizedBox(height: 5),
                  DetailPadding(
                      child:  Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.predictResult.value![0]!.keys!.first!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp
                          ),
                        ),
                      )
                  ),
                  DetailPadding(
                      child: Row(
                        children: [
                          Text(
                            'Accuracy :',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp
                            ),
                          ),
                          Spacer(),
                          CircularPercentIndicator(
                            radius: 30.0,
                            lineWidth: 6.0,
                            percent: controller.predictResult.value![0]!.values!.first!/100,
                            center: new Text("${controller.predictResult.value![0]!.values!.first!}%"),
                            progressColor: Colors.green,
                          )
                        ],
                      )
                  ),
                ],
              ),
            )
        )
    );
  }
}
