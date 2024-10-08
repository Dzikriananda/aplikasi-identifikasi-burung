import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/gen/assets.gen.dart';
import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/local/local_storage/local_storage.dart';
import 'package:bird_guard/src/presentation/module/global_widget/container_item.dart';
import 'package:bird_guard/src/presentation/module/global_widget/custom_dialog.dart';
import 'package:bird_guard/src/presentation/module/global_widget/primary_button.dart';
import 'package:bird_guard/src/presentation/module/global_widget/stateful_handle_widget.dart';
import 'package:bird_guard/src/presentation/module/home/bird_species_list_screen/widget/bird_species_list_item.dart';
import 'package:bird_guard/src/viewmodel/bird_species_list_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BirdSpeciesListScreen extends GetView<BirdSpeciesListScreenViewModel> {
  const BirdSpeciesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text('species_list_screen_1'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "species_list_dialog_title".tr,
                middleText: "species_list_dialog_content".tr,
                confirm: PrimaryButton(
                  onPressed: () => Get.back(),
                )
              );
            },
            icon: const Icon(Icons.question_mark),
          )
        ],
      ),
      body: Obx(
          () => RefreshIndicator(
            onRefresh: () => controller.getSpeciesList(),
            child: StatefulHandleWidget(
                errorEnabled: controller.isError.value,
                loadingEnabled: controller.isLoading.value || controller.isError.value,
                stackLoadingWidget: false,
                loadingView: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                    ),
                    itemCount: 10,
                    itemBuilder: (context,index) {
                      return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: CustomColor.historyItemColor,
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                            ),
                            height: 155.h,
                            width: 155.w,
                            child: Column(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 120.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300]!,
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 15.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300]!,
                                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                      );
                    }
                ),
                errorView: CustomDialog(
                  isError: true,
                  message: controller.data.value?.message,
                  ignoreClick: false,
                  firstButtonTitle: 'Retry',
                  onPressedFirstButton: () {
                    controller.getSpeciesList();
                  },
                ),
                body: Builder(
                    builder: (context) {
                      return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // number of items in each row
                            mainAxisSpacing: 8.0, // spacing between rows
                            crossAxisSpacing: 8.0, // spacing between columns
                          ),
                          itemCount: controller.data!.value!.data.length,
                          itemBuilder: (context,index) {
                            return Center(
                                child: BirdSpeciesListItem(data: controller.data!.value!.data[index])
                            );
                          }
                      );
                    }
                )
            ),
          )
      )

    );
  }
}
