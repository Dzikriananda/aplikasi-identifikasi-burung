import 'package:bird_guard/src/presentation/module/global_widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.isError = false,
    this.ignoreClick = true,
    this.buttonTitle,
    this.onPressed,
    this.message
  });

  final bool isError;
  final bool ignoreClick;
  final String? message;
  final String? buttonTitle;
  final VoidCallback? onPressed;


  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ignoreClick,
      child: Container(
        // width: 300.w,
        constraints: BoxConstraints(
          minHeight: 200.h,
          maxHeight: 250.h
        ),
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xffe8e7ef),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Visibility(
              visible: isError,
              child:  PrimaryButton(
                    onPressed: () {
                      if(onPressed!=null) {
                        onPressed!();
                      }
                },
                title: buttonTitle,
              )
            )
          ],
        ),
      ),
    );
  }
}