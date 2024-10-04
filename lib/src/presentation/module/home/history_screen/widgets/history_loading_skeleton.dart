import 'package:bird_guard/src/core/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HistoryLoadingSkeleton extends StatelessWidget {
  const HistoryLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      addAutomaticKeepAlives: true,
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
       if(index < 5) {
         return Padding(
           padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
           child: Container(
             height: 100.h,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               color: CustomColor.historyItemColor,
             ),
             child: Row(
               children: [
                 Shimmer.fromColors(
                   baseColor: Colors.grey[300]!,
                   highlightColor: Colors.grey[100]!,
                   child: Container(
                     height: 100.h,
                     width: 120.w,
                     decoration: BoxDecoration(
                       color: Colors.grey[300]!,
                       borderRadius: const BorderRadius.all(Radius.circular(15)),
                     ),
                   ),
                 ),
                 const SizedBox(
                   width: 80,
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Shimmer.fromColors(
                       baseColor: Colors.grey[300]!,
                       highlightColor: Colors.grey[100]!,
                       child: Container(
                         height: 25.h,
                         width: 120.w,
                         decoration: BoxDecoration(
                           color: Colors.grey[300]!,
                           borderRadius: const BorderRadius.all(Radius.circular(15)),
                         ),
                       ),
                     ),
                     SizedBox(height: 10),
                     Shimmer.fromColors(
                       baseColor: Colors.grey[300]!,
                       highlightColor: Colors.grey[100]!,
                       child: Container(
                         height: 25.h,
                         width: 120.w,
                         decoration: BoxDecoration(
                           color: Colors.grey[300]!,
                           borderRadius: const BorderRadius.all(Radius.circular(15)),
                         ),
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(width: 5),
               ],
             ),
           ),
         );
       } else {
         return Padding(
           padding: EdgeInsets.symmetric(vertical: 8,horizontal: 0),
           child: Center(
             child: CircularProgressIndicator(),
           ),
         );
       }
      },
    );
  }
}
