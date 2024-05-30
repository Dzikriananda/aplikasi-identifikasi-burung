import 'package:bird_guard/src/presentation/module/global_widget/loading_wrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatefulHandleWidget extends StatefulWidget {
  /// can override setting Visibility emptyView even if [emptyEnabled] is true
  final bool visibleOnEmpty;

  /// can override setting Visibility emptyView even if [errorEnabled] is true
  final bool visibleOnError;

  /// controller view state "true" mean show loadingView
  final bool loadingEnabled;

  /// controller view state "true" mean show emptyView
  final bool emptyEnabled;

  final bool stackLoadingWidget;

  /// controller view state "true" mean show errorView
  final bool errorEnabled;

  /// loading view that will show if [loadingEnabled] is true
  final Widget? loadingView;

  /// image that will show if [emptyEnabled] is true
  final ImageProvider? emptyImage;

  /// title that will show if [emptyEnabled] is true
  final String? emptyTitle;

  /// subtitle that will show if [emptyEnabled] is true
  final String? emptySubtitle;

  /// image that will show if [errorEnabled] is true
  final ImageProvider? errorImage;

  /// title that will show if [errorEnabled] is true
  final String? errorTitle;

  /// subtitle that will show if [errorEnabled] is true
  final String? errorSubtitle;


  /// function to controll onPress 'retry' if [errorEnabled] is true
  final void Function()? onRetryPressed;

  final Alignment? loadingAlign;

  /// main body / main content / success view
  /// usualy widget that show data
  final Widget body;

  final Widget errorView;

  const StatefulHandleWidget({
    Key? key,
    required this.body,
    this.emptyImage,
    this.emptyTitle,
    this.emptySubtitle,
    this.onRetryPressed,
    this.loadingView,
    this.emptyEnabled = false,
    this.loadingEnabled = false,
    this.stackLoadingWidget = false,
    this.errorEnabled = false,
    this.visibleOnEmpty = true,
    this.visibleOnError = true,
    this.loadingAlign,
    this.errorImage,
    this.errorView = const Icon(Icons.error),
    this.errorSubtitle,
    this.errorTitle,
  }) : super(key: key);

  @override
  StatefulHandleWidgetState createState() => StatefulHandleWidgetState();
}

class StatefulHandleWidgetState extends State<StatefulHandleWidget> {
  @override
  Widget build(BuildContext context) {
    var loadingWidget = widget.loadingView ?? const CircularProgressIndicator();

    return Stack(
      alignment: widget.loadingAlign ?? AlignmentDirectional.topStart,
      children: [
        getBodyWidget(),
        getErrorView(),
        getEmptyView(),
        Center(
          child: LoadingWrap(isLoading: widget.loadingEnabled,loadingWidget: loadingWidget),
        ),
        Center(
          child: LoadingWrap(isLoading: widget.errorEnabled,loadingWidget: widget.errorView),
        )
        // getLoadingView(loadingWidget),
      ],
    );
  }

  // Widget getBodyWidget() =>
  //     widget.loadingEnabled || widget.emptyEnabled || widget.errorEnabled
  //         ? Container()
  //         : widget.body;

  Widget getBodyWidget() =>
      (widget.stackLoadingWidget) ? widget.body :
          (widget.loadingEnabled || widget.emptyEnabled || widget.errorEnabled
              ? Container() : widget.body
          );

  Widget getLoadingView(Widget loadingWidget) => widget.loadingEnabled
      ? Center(
    child: AnimatedOpacity(
      opacity: widget.loadingEnabled ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: loadingWidget,
    ),
  )
      : Container();

  Widget getEmptyView() => widget.visibleOnEmpty &&
      widget.emptyEnabled &&
      !widget.errorEnabled &&
      !widget.loadingEnabled
      ? buildEmpty()
      : Container();

  Widget buildEmpty() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image(
        //   width: 180,
        //   height: 150,
        //   fit: BoxFit.fill,
        //   image: widget.emptyImage ?? AppImages.imgEmpty.image().image,
        // ),
        Container(
          margin: const EdgeInsets.fromLTRB(24, 40, 24, 20),
          child: Text(
            widget.emptyTitle ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontStyle: FontStyle.normal),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Text(
            widget.emptySubtitle ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );

  Widget getErrorView() =>
      widget.visibleOnError && widget.errorEnabled ? buildError() : Container();

  Widget buildError() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image(
        //   width: 180,
        //   height: 150,
        //   fit: BoxFit.fill,
        //   image: widget.errorImage ?? AppImages.imgError.image().image,
        // ),
        Container(
          margin: const EdgeInsets.fromLTRB(24, 40, 24, 10),
          child: Text(
            widget.errorSubtitle ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontStyle: FontStyle.normal),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 40),
          child: Text(
            widget.errorTitle ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        // TextButton(
        //   onPressed: widget.onRetryPressed,
        //   child: Text(
        //     'txt_retry'.tr,
        //   ),
        // )
      ],
    ),
  );
}
