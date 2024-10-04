import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/presentation/module/global_widget/primary_button.dart';
import 'package:bird_guard/src/viewmodel/system_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StorageCacheManagementScreen extends StatelessWidget {
  const StorageCacheManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return GetBuilder(
        init: SystemController(),
        builder: (controller) {
          controller.getStorageInfo();
          return PopScope(
            canPop: true,
            onPopInvoked: (_) {
              controller.setImageCompressionLevel();
            },
            child: Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                        child: Container(
                            decoration: BoxDecoration(
                              color: CustomColor.surfaceContainerHighest,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                            child: Row(
                              children: [
                                CircularPercentIndicator(
                                  radius: 60.0,
                                  lineWidth: 15.0,
                                  percent: (((controller.info.appCacheSize)! / 200) < 1) ?
                                    ((controller.info.appCacheSize)! / 200) : 1,
                                  center: SizedBox(
                                    width: 100,
                                    child: Text(
                                      "${(((controller.info.appCacheSize)! / 200) * 100).toStringAsFixed(2)} %",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                  progressColor: Colors.blue,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "storage_cache_screen_1".tr,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "storage_cache_screen_2".trParams(
                                              {'1': controller.info?.appCacheSize?.toStringAsFixed(2) ?? '0', '2' :'200'}),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.titleSmall,
                                        ),
                                      ],
                                    )
                                )

                              ],
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child:  Text(
                                    'storage_cache_screen_3'.trParams({
                                      '1' : controller.info?.appCacheSize?.toStringAsFixed(2) ?? '0'
                                    }),
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                PrimaryButton(
                                  title: 'storage_cache_screen_4'.tr,
                                  onPressed: ()  async {
                                    await controller.clearCache();
                                  },
                                )
                              ],
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                            child: Column(
                              children: [
                                Text(
                                  'storage_cache_screen_5'.tr,
                                  textAlign: TextAlign.justify,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                      trackHeight: 11,
                                  ),
                                  child: Slider(
                                    value: controller.sliderValue,
                                    max: 95,
                                    divisions: 19,
                                    label: controller.sliderValue.round().toString(),
                                    onChanged: (double value) {
                                      controller.sliderValue = value;
                                    },
                                  ),
                                ),
                                Text(
                                  'storage_cache_screen_6'.tr   ,
                                  textAlign: TextAlign.justify,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),

                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                )
            ),
          );
        }
      );
  }
}
