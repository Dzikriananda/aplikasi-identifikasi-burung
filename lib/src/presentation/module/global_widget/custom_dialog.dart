import 'package:bird_guard/src/presentation/module/global_widget/primary_button.dart';
import 'package:bird_guard/src/presentation/module/global_widget/primary_button_outlined.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.isError = false,
    this.ignoreClick = true,
    this.needSecondaryButton = false,
    this.firstButtonTitle,
    this.onPressedFirstButton,
    this.onPressedSecondaryButton,
    this.secondaryButtonTitle,
    this.message,
    this.statusCode,
  });

  final bool isError;
  final bool ignoreClick;
  final bool needSecondaryButton;
  final String? message;
  final String? firstButtonTitle;
  final String? secondaryButtonTitle;
  final int? statusCode;
  final VoidCallback? onPressedFirstButton;
  final VoidCallback? onPressedSecondaryButton;



  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ignoreClick,
      child: Container(
        // width: 300.w,
        constraints: BoxConstraints(
          // minHeight: 200.h,
          // maxHeight: 250.h
            minHeight: 150.h,
            maxHeight: 250.h
        ),
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xffe8e7ef),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            SizedBox(
              child: (isError) ? Icon(Icons.error,size: 50)
                  : CircularProgressIndicator(),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300.w,
              child: Text(
                message ?? 'Please Wait...',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.h),
            Visibility(
              visible: isError,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (needSecondaryButton) ?  PrimaryButtonOutlined(
                    onPressed: () {
                      if(onPressedSecondaryButton!=null) {
                        onPressedSecondaryButton!();
                      }
                    },
                    title: 'Close',
                  ) : Container(),
                  (needSecondaryButton) ? SizedBox(width: 10) : Container(),
                  PrimaryButton(
                    onPressed: () {
                      if(onPressedFirstButton!=null) {
                        onPressedFirstButton!();
                      }
                    },
                    title: firstButtonTitle,
                  ),

                ],
              )
            )
          ],
        ),
      ),
    );
  }
}