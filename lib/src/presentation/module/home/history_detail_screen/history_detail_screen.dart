import 'dart:io';
import 'dart:typed_data';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/history_response.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:bird_guard/src/presentation/module/detect/detail_screen/widget/detail_padding.dart';
import 'package:bird_guard/src/viewmodel/detail_screen_viewmodel.dart';
import 'package:bird_guard/src/viewmodel/history_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HistoryDetailScreen extends StatelessWidget {
  HistoryDetailScreen({super.key});

  final HistoryResponse data = Get.arguments;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(data.createdAt.toString()),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 250.h,
                width: double.infinity,
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
              SizedBox(height: 15),
              DetailPadding(
                  child:  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data.result!,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp
                      ),
                    ),
                  )
              ),
              SizedBox(height: 5),
              DetailPadding(
                  child: Row(
                    children: [
                      Text(
                        'Accuracy :',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp
                        ),
                      ),
                      Spacer(),
                      CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 10.0,
                        percent: data.confidence!/100,
                        center: Text("${data.confidence!.truncate()}%"),
                        progressColor: Colors.green,
                      )
                    ],
                  )
              ),
              SizedBox(height: 5),
            ],
          ),
        )
    );
  }
}
