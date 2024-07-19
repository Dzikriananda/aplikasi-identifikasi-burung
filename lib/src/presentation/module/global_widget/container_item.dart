// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:bird_guard/src/core/gen/assets.gen.dart';
// import 'package:bird_guard/src/core/styles/custom_color.dart';
// import 'package:bird_guard/src/data/model/history_response.dart';
// import 'package:bird_guard/src/route/route_name.dart';
// import 'package:bird_guard/src/viewmodel/history_screen_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class ContainerItem extends StatelessWidget {
//   ContainerItem({super.key,this.imagePath,required this.data});
//
//   final String? imagePath;
//   final HistoryResponse data;
//   final controller =  Get.find<HistoryScreenViewModel>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.hardEdge,
//       decoration: BoxDecoration(
//         color: CustomColor.historyItemColor,
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.35),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       height: 155.h,
//       width: 155.w,
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Get.toNamed(RouteName.historyDetailScreen,arguments: data);
//             },
//             child: SizedBox(
//               height: 120.h,
//               width: double.infinity,
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(15.0),
//                   child: FutureBuilder(
//                       future: controller.getPreviewImage(data.id.toString()),
//                       builder: (context,snapshot) {
//                         if(snapshot.connectionState == ConnectionState.done) {
//                           if(snapshot.hasData) {
//                             return FittedBox(
//                               fit: BoxFit.fill,
//                               child: Image.memory(snapshot.data as Uint8List),
//                             );
//                           } else {
//                             return const Center(
//                                 child: Icon(Icons.not_interested)
//                             );
//                           }
//                         } else {
//                           return const CircularProgressIndicator();
//                         }
//                       }
//                   )
//               ),
//             ),
//           ),
//           Expanded(
//               child: Container(
//                   child: Center(
//                     child: Text(
//                       data.result!,
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                   )
//               )
//           )
//         ],
//       ),
//     );
//   }
// }
