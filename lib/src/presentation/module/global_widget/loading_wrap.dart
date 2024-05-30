import 'package:flutter/material.dart';

class LoadingWrap extends StatelessWidget {
  const LoadingWrap({
    super.key,
    required this.isLoading,
    this.loadingWidget = const CircularProgressIndicator()
  });
  final bool isLoading;
  final Widget loadingWidget;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLoading ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: loadingWidget,
    );
  }
}
