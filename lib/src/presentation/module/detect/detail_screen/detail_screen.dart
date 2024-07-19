import 'dart:io';
import 'package:bird_guard/src/core/util/util.dart';
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
              title: Text('result_screen_appbar'.tr),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(File(controller.imagePath)),
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  const SizedBox(height: 15),
                  DetailPadding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  controller.response.value!.data.result,
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.sp
                                  )
                              ),
                              Text(
                                controller.birdData.value!.scientificName!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 12.0,
                          percent: controller.birdData.value!.confidence!/100,
                          center: Text(
                            "${controller.birdData.value!.confidence!.toStringAsFixed(2)}%",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          progressColor: Colors.green,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  DetailPadding(
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'result_screen_1'.tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child:  Text(
                            controller.birdData.value!.category!,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Helper.getStatusColor(controller.birdData.value!.category!),
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  DetailPadding(
                    child: Text(
                      controller.birdData.value!.description!,
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}
