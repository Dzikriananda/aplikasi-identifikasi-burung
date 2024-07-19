import 'dart:typed_data';
import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/core/util/string_util.dart';
import 'package:bird_guard/src/data/model/history_response.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:bird_guard/src/viewmodel/history_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryItem extends StatelessWidget {
  HistoryItem({super.key,this.imagePath,required this.data});

  final String? imagePath;
  final HistoryResponse data;
  final controller =  Get.find<HistoryScreenViewModel>();
  // final storage = locator<BirdRepository>();
  //
  // Future<Uint8List?> configureImage() async {
  //   Uint8List? cache = await storage.readHistoryCache(data.id!);
  //   if(cache==null) {
  //     Uint8List? dataImage = await controller.getPreviewImage(data.id.toString());
  //     if(dataImage!=null) {
  //       storage.addHistoryCache(dataImage, data.id!);
  //     }
  //     return dataImage;
  //   } else {
  //     return cache;
  //   }
  // }

  Future<Uint8List?> configureImage() async {
    Uint8List? cache = await controller.getCachePreviewImage(data.id!);
    if(cache==null) {
      Uint8List? dataImage = await controller.getPreviewImage(data.id.toString());
      if(dataImage!=null) {
        controller.addHistoryCache(dataImage, data.id!);
      }
      return dataImage;
    } else {
      return cache;
    }
  }

  // Future<Uint8List?> configureImage() async {
  //   Uint8List? cache = await controller.getImageCache(data.id!);
  //   if(cache==null) {
  //     Uint8List? dataImage = await controller.getPreviewImage(data.id.toString());
  //     if(dataImage!=null) {
  //       controller.addImageCache(dataImage, data.id!);
  //     }
  //     return dataImage;
  //   } else {
  //     return cache;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print('membuat item ${data.toJson()}');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: Container(
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
        width: 155.w,
        child: InkWell(
            onTap: () {
              print('mi sukses');
              Get.toNamed(RouteName.historyDetailScreen,arguments: data);
            },
            child: Row(
              children: [
                SizedBox(
                  height: 100.h,
                  width: 120.w,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: FutureBuilder(
                          future: configureImage(),
                          builder: (context,snapshot) {
                            if(snapshot.connectionState == ConnectionState.done) {
                              if(snapshot.hasData) {
                                return FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.memory(snapshot.data as Uint8List),
                                );
                              } else {
                                return const Center(
                                    child: Icon(Icons.not_interested)
                                );
                              }
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }
                      )
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        StringUtil.nameFormat(data.result!),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        StringUtil.dateFormat(data.createdAt!),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
              ],
            )
        ),
      ),
    );
  }
}
