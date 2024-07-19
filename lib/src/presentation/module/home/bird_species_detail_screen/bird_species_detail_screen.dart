import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/util.dart';
import 'package:bird_guard/src/presentation/module/detect/detail_screen/widget/detail_padding.dart';
import 'package:bird_guard/src/viewmodel/bird_detail_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BirdSpeciesDetailScreen extends GetView<BirdDetailScreenViewModel> {
  const BirdSpeciesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Scaffold(
            appBar: AppBar(
              title: Text('Bird Detail'.tr),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                       () {
                        if(controller.status.value == Status.loading) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 250.h,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[300]
                                ),
                              ),
                            ),
                          );
                        } else if(controller.status.value == Status.success) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: MemoryImage(controller.imageData.value!),
                                ),
                                borderRadius: BorderRadius.circular(20)
                            ),
                          );
                        } else {
                          return Icon(Icons.error,size: 80);
                        }
                      }
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
                                  controller.data.value!.name!,
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.sp
                                  )
                              ),
                              Text(
                                controller.data.value!.scientificName!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  DetailPadding(
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'result_screen_1'.tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child:  Text(
                            controller.data.value!.category!,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Helper.getStatusColor(controller.data.value!.category!),
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
                      controller.data.value!.description!,
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
