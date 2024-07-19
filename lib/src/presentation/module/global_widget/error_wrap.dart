import 'package:flutter/material.dart';

class ErrorWrap extends StatelessWidget {
  const ErrorWrap({
    super.key,
    required this.isError,
    this.errorWidget = const Icon(Icons.error)
  });
  final bool isError;
  final Widget errorWidget;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isError,
      child: AnimatedOpacity(
        opacity: isError ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: errorWidget,
      ),
    );
  }
}
