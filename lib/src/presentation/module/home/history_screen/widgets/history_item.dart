import 'dart:io';
import 'dart:typed_data';
import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/core/util/string_util.dart';
import 'package:bird_guard/src/data/model/history_response.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:bird_guard/src/viewmodel/history_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({super.key, this.imagePath, required this.data});

  final String? imagePath;
  final HistoryResponse data;

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  final controller = Get.find<HistoryScreenViewModel>();
  final imageStatusNotifier = ValueNotifier<Status>(Status.loading);
  String? imagePath;

  @override
  void initState() {
    super.initState();
    configureImage();
  }



  @override
  void dispose() {
    if(imagePath == null) {
      controller.cancelApiCall(widget.data.id.toString());
    }
    super.dispose();
  }


  Future<void> configureImage() async {
    imageStatusNotifier.value = Status.loading;
    String? cache = await controller.getCachePreviewImage(widget.data.id!);
    if (cache == null) {
      Uint8List? dataImage = await controller.getPreviewImage(widget.data.id.toString());
      if (dataImage != null) {
        await controller.addHistoryCache(dataImage, widget.data.id!);
      }
      String? path = await controller.getCachePreviewImage(widget.data.id!);
      if (path != null) {
        if(mounted) {
          setState(() {
            imagePath = path;
          });
        }
        imageStatusNotifier.value = Status.success;
      } else {
        imageStatusNotifier.value = Status.error;
      }
    } else {
      if(mounted) {
        setState(() {
          imagePath = cache;
        });
      }
      imageStatusNotifier.value = Status.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
            onTap: () async {
              if(imagePath == null) {
                controller.cancelApiCall(widget.data.id.toString());
                var res = await Get.toNamed(RouteName.historyDetailScreen, arguments: widget.data);
                print('res adalah $res');
                configureImage();
              } else {
                Get.toNamed(RouteName.historyDetailScreen, arguments: widget.data);
              }
            },
            child: Row(
              children: [
                SizedBox(
                  height: 100.h,
                  width: 120.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: ValueListenableBuilder<Status>(
                      valueListenable: imageStatusNotifier,
                      builder: (context, imageStatus, child) {
                        if (imageStatus == Status.loading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (imageStatus == Status.success) {
                          return FittedBox(
                            fit: BoxFit.fill,
                            child: Image.file(
                              File(imagePath!),
                              gaplessPlayback: true,
                            ),
                          );
                        } else {
                          return const Center(child: Icon(Icons.error));
                        }
                      },
                    ),
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
                        StringUtil.nameFormat(widget.data.result!),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        StringUtil.dateFormat(widget.data.createdAt!),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
              ],
            )),
      ),
    );
  }
}
