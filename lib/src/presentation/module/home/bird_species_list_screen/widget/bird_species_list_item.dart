import 'dart:typed_data';

import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:bird_guard/src/data/model/bird_species_response.dart';
import 'package:bird_guard/src/route/app_route.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:bird_guard/src/viewmodel/bird_species_list_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BirdSpeciesListItem extends StatelessWidget {
  BirdSpeciesListItem({
    super.key,
    required this.data
  });

  BirdSpeciesListScreenViewModel controller = Get.find<BirdSpeciesListScreenViewModel>();
  BirdSpeciesResponse data;

  Future<Uint8List?> configureImage() async {
    Uint8List? cache = await controller.getCachePreviewImage(data.id!);
    if(cache==null) {
      Uint8List? dataImage = await controller.getPreviewImage(data.id.toString());
      if(dataImage!=null) {
        controller.addSpeciesListCache(dataImage, data.id!);
      }
      return dataImage;
    } else {
      return cache;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.birdSpeciesListDetailScreen,arguments: data);
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: CustomColor.historyItemColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 155.h,
        width: 155.w,
        child: Column(
          children: [
            Container(
              height: 120.h,
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
            // Spacer(),
            Expanded(
                child: Container(
                    child: Center(
                      child: Text(
                        data.name!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                )
            )
          ],
        ),
      ),
    );
  }
}
