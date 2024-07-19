import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/data/local/local_storage/local_storage.dart';
import 'package:bird_guard/src/presentation/module/global_widget/container_item.dart';
import 'package:bird_guard/src/presentation/module/global_widget/custom_dialog.dart';
import 'package:bird_guard/src/presentation/module/global_widget/primary_button.dart';
import 'package:bird_guard/src/presentation/module/global_widget/stateful_handle_widget.dart';
import 'package:bird_guard/src/presentation/module/home/history_screen/widgets/history_item.dart';
import 'package:bird_guard/src/viewmodel/history_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/util/locator.dart';

class HistoryScreen extends GetView<HistoryScreenViewModel> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text('history_screen_1'.tr),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                Get.defaultDialog(
                    title: 'history_dialog_title'.tr,
                    middleText: 'history_dialog_content'.tr,
                    confirm: PrimaryButton(
                      onPressed: () => Get.back(),
                    )
                );
              },
              icon: Icon(Icons.question_mark),
            )
          ],
        ),
        body: GetBuilder(
          init: HistoryScreenViewModel(),
          builder: (_) {
            return RefreshIndicator(
                child: StatefulHandleWidget(
                  loadingEnabled: controller.isLoading,
                  emptyEnabled: controller.isEmpty,
                  emptyTitle: 'history_empty_title'.tr,
                  errorEnabled: controller.isError,
                  errorView: CustomDialog(
                    isError: true,
                    message: controller.data?.message,
                    ignoreClick: false,
                    buttonTitle: 'Retry',
                    onPressed: () => controller.configureList(),
                  ),
                  body: Builder(
                    builder: (context) {
                      return ListView.builder(
                        // addAutomaticKeepAlives: true,
                        itemCount: controller.data!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HistoryItem(data: controller.data!.data![index]);
                        },
                      );
                    },
                  ),
                ),
                onRefresh: () async {
                  controller.configureList();
                }
            );
          },
        )
    );
  }
}
