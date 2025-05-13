import 'package:flutter/material.dart';
import 'package:pretium_app/core/res/gap.dart';

class VBottomSheetComponent {
  static Future<T?> actionBottomSheet<T>({
    required BuildContext context,
    bool showBottomSheet = true,
    required List<VBottomSheetItem> actions,
    Widget? customHeader,
    Widget Function(BuildContext)? customFooter,
  }) {
    return _showCustomModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      builder: (context) => VBottomSheetWidget(
        actions: actions,
        showBottomDivider: showBottomSheet,
        customHeader: customHeader,
        customFooter: customFooter,
      ),
    );
  }

  static Future customBottomSheet({
    required BuildContext context,
    required Widget child,
    bool showBottomDivider = true,
    AnimationController? transitionAnimationController,
    bool isScrollControlled = true,
    bool removeSidePadding = false,
    bool useRootNavigator = true,
  }) =>
      _showCustomModalBottomSheet(
        context: context,
        isScrollControlled: true,
        transitionAnimationController: transitionAnimationController,
        useSafeArea: true,
        useRootNavigator: useRootNavigator,
        builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VBottomSheetWidget(
                customChild: child,
                removeSidePadding: removeSidePadding,
                showBottomDivider: showBottomDivider,
              )
            ]),
      );

  static Future customStatefulBottomSheet({
    required BuildContext context,
    required Widget Function(Function(void Function())) child,
    bool isScrollControlled = false,
    bool showBottomSheet = true,
    bool useRootNavigator = false,
    bool removeSidePadding = false,
  }) =>
      _showCustomModalBottomSheet<Widget>(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(children: [
                  VBottomSheetWidget(
                    customChild: child(setState),
                    removeSidePadding: removeSidePadding,
                    showBottomDivider: showBottomSheet,
                  ),
                ]),
              );
            });
          });
}

//TODO: solve the background issue that may occur here
class VBottomSheetWidget extends StatefulWidget {
  const VBottomSheetWidget({
    super.key,
    this.actions,
    this.customChild,
    required this.showBottomDivider,
    this.removeSidePadding = false,
    this.customHeader,
    this.customFooter,
  });
  final List<VBottomSheetItem>? actions;
  final Widget? customChild;
  final bool showBottomDivider, removeSidePadding;
  final Widget? customHeader;
  final Widget Function(BuildContext)? customFooter;

  @override
  State<VBottomSheetWidget> createState() => _VBottomSheetWidgetState();
}

class _VBottomSheetWidgetState extends State<VBottomSheetWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: const ElasticOutCurve(0.95), // Curves.elasticOut,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: widget.removeSidePadding ? 0 : 16,
        right: widget.removeSidePadding ? 0 : 16,
        bottom: 25,
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .55,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              15.verticalSpacing,
              const Align(
                  alignment: Alignment.center, child: VWidgetsModalPill()),
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.customHeader != null) widget.customHeader!,
                      if (widget.actions != null) ...[
                        Flexible(
                          child: ListView.builder(
                            physics: const ScrollPhysics(),
                            itemCount: widget.actions!.length,
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            shrinkWrap: true,
                            itemBuilder: ((context, index) => InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  overlayColor: const WidgetStatePropertyAll(
                                      Colors.transparent),
                                  onTap: () =>
                                      widget.actions![index].onTap(context),
                                  child: Container(
                                    height: 52,
                                    color: Colors.transparent,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          if (widget.actions![index].icon !=
                                              null) ...[
                                            widget.actions![index].icon!,
                                            addHorizontalSpacing(16),
                                          ],
                                          Text(
                                            widget.actions![index].title,
                                            style: widget
                                                    .actions![index].style ??
                                                Theme.of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .copyWith(
                                                      fontWeight: widget
                                                              .actions![index]
                                                              .textWeight ??
                                                          FontWeight.w600,
                                                      color: widget
                                                              .actions![index]
                                                              .textColor ??
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      fontSize: 16,
                                                    ),
                                          ),
                                          if (widget.actions![index].endIcon !=
                                              null) ...[
                                            Spacer(),
                                            widget.actions![index].endIcon!,
                                            10.horizontalSpacing,
                                          ]
                                        ]),
                                  ),
                                )),
                          ),
                        ),
                        if (widget.customFooter != null)
                          widget.customFooter!(context),
                      ],
                      if (widget.customChild != null) ...[
                        widget.customChild!,
                      ],
                    ]),
              ),

              // addVerticalSpacing(10),
            ]),
      ),
    );
  }
}

Future<T?> _showCustomModalBottomSheet<T>(
    {required BuildContext context,
    required WidgetBuilder builder,
    double? elevation,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool? useSafeArea,
    bool isScrollControlled = false,
    bool useRootNavigator = true,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    // required String paddingChild,
    EdgeInsets padding = EdgeInsets.zero}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (BuildContext context) {
      return builder(context);
    },
    backgroundColor: Colors.transparent,
    elevation: elevation,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    clipBehavior: clipBehavior,
    useSafeArea: useSafeArea ?? false,
    constraints: constraints,
    barrierColor: barrierColor,
    isScrollControlled: true,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    routeSettings: routeSettings,
    transitionAnimationController: transitionAnimationController,
    anchorPoint: anchorPoint,
  );
}

class VBottomSheetItem {
  final Widget? icon;
  final Widget? endIcon;
  final Function(BuildContext) onTap;
  final String title;
  @Deprecated('Use style instead')
  final Color? textColor;
  @Deprecated('Use style instead')
  final FontWeight? textWeight;
  final TextStyle? style;

  VBottomSheetItem({
    this.icon,
    required this.onTap,
    required this.title,
    @Deprecated('Use style instead') this.textColor,
    @Deprecated('Use style instead') this.textWeight,
    this.endIcon,
    this.style,
  });
}

class VWidgetsModalPill extends StatelessWidget {
  const VWidgetsModalPill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor.withOpacity(.15),
      ),
    );
  }
}
