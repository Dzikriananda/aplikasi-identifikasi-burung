import 'dart:io';
import 'dart:typed_data';
import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/core/util/string_util.dart';
import 'package:bird_guard/src/core/util/util.dart';
import 'package:bird_guard/src/data/model/history_response.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:bird_guard/src/presentation/module/detect/detail_screen/widget/detail_padding.dart';
import 'package:bird_guard/src/presentation/module/global_widget/detail_bird_image_loading.dart';
import 'package:bird_guard/src/viewmodel/detail_screen_viewmodel.dart';
import 'package:bird_guard/src/viewmodel/history_detail_screen_viewmodel.dart';
import 'package:bird_guard/src/viewmodel/history_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HistoryDetailScreen extends GetView<HistoryDetailScreenViewModel> {
  const HistoryDetailScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        if(!value) {
          Get.back(result: controller.hasImage.value);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(StringUtil.dateFormat(controller.data.value!.createdAt!)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 250.h,
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: FutureBuilder(
                          future: controller.configureImage(),
                          builder: (context,snapshot) {
                            if(snapshot.connectionState == ConnectionState.done) {
                              if(snapshot.hasData) {
                                return FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.file(File(snapshot.data!)),
                                );
                              } else {
                                return const Center(
                                    child: Icon(Icons.not_interested,size: 100)
                                );
                              }
                            } else {
                              return const DetailBirdImageLoading();
                            }
                          }
                      )
                  ),
                ),
                SizedBox(height: 15),
                Obx(
                        () {
                      if(controller.status.value == Status.loading) {
                        return CircularProgressIndicator();
                      } else {
                        return Column(
                          children: [
                            DetailPadding(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            controller.response.value!.data!.name!,
                                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.sp
                                            )
                                        ),
                                        Text(
                                          controller.response.value!.data.scientificName!,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  CircularPercentIndicator(
                                    radius: 50.0,
                                    lineWidth: 12.0,
                                    percent: controller.data.value!.confidence!/100,
                                    center: Text(
                                      "${controller.data.value!.confidence!.toStringAsFixed(2)}%",
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
                                      controller.response.value!.data.category!,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Helper.getStatusColor(controller.response.value!.data.category!),
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
                                controller.response.value!.data.description!,
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        );
                      }
                    }
                )
              ],
            ),
          )
      ),
    );
  }
}
