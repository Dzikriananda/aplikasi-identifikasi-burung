import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/gen/assets.gen.dart';
import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/presentation/module/global_widget/container_item.dart';
import 'package:bird_guard/src/presentation/module/global_widget/primary_button.dart';
import 'package:bird_guard/src/viewmodel/history_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryScreen extends GetView<HistoryScreenViewModel> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.deleteHistory(),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text('history_screen_1'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
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
          if(controller.status == Status.loading) {
            return CircularProgressIndicator();
          } else if(controller.status == Status.success) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
              ),
              itemCount: controller.data!.length,
              itemBuilder: (context,index) {
                return Center(
                  child: ContainerItem(
                    imagePath: controller.data![index].imagePath,
                    title: 'ambanana',
                  ),
                );
              }
            );
          } else {
            return Icon(Icons.not_accessible_sharp);
          }
        },
      )
    );
  }
}
