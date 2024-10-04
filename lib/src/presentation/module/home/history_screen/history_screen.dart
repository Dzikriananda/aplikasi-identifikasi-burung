import 'package:bird_guard/src/presentation/module/global_widget/custom_dialog.dart';
import 'package:bird_guard/src/presentation/module/global_widget/primary_button.dart';
import 'package:bird_guard/src/presentation/module/global_widget/stateful_handle_widget.dart';
import 'package:bird_guard/src/presentation/module/home/history_screen/widgets/history_item.dart';
import 'package:bird_guard/src/presentation/module/home/history_screen/widgets/history_loading_skeleton.dart';
import 'package:bird_guard/src/viewmodel/history_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
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
          builder: (controller) {
            return RefreshIndicator(
                child: StatefulHandleWidget(
                  loadingEnabled: controller.isLoading || controller.isError  ,
                  emptyEnabled: controller.isEmpty,
                  loadingView: const HistoryLoadingSkeleton(),
                  emptyTitle: 'history_empty_title'.tr,
                  errorEnabled: controller.isError,
                  errorView: CustomDialog(
                    isError: true,
                    message: controller.data?.message,
                    ignoreClick: false,
                    firstButtonTitle: 'Retry',
                    onPressedFirstButton: () => controller.configureList(),
                  ),
                  body: Builder(
                    builder: (context) {
                      return ListView.builder(
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
