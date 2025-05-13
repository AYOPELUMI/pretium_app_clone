import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_app/core/res/theme.dart';
import 'package:pretium_app/core/router/router.gr.dart';

import '../../core/providers/auth_provider.dart';
import '../../widgets/bottom_sheet.dart';

@RoutePage()
class HomeTabScreen extends ConsumerStatefulWidget {
  const HomeTabScreen({super.key});

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends ConsumerState<HomeTabScreen> {
  int lastTappedIndex = -1;
  DateTime? lastBackPressTime;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final authState = ref.read(authStateProvider);
      authState.whenOrNull(
        data: (isLoggedIn) {
          if (isLoggedIn.isAuthenticated) {
            FlutterNativeSplash.remove();
          }
        },
        error: (_, __) {
          FlutterNativeSplash.remove();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (lastBackPressTime == null ||
            now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
          lastBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Tap/swipe again to exit"),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // Prevent exit on the first back press
        }
        return true; // Exit on the second back press within 2 seconds
      },
      child: DefaultTabController(
        length: 3,
        child: AutoTabsRouter(
            routes: [
              DashboardRoute(),
              DashboardRoute(),
              RecentTransactionsRoute()
            ],
            lazyLoad: false,
            builder: (context, child) {
              final tabRouter = AutoTabsRouter.of(context);
              return Scaffold(
                body: child,
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  height: 65,
                  child: TabBar(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      tabAlignment: TabAlignment.fill,
                      labelPadding: EdgeInsets.zero,
                      isScrollable: false,
                      indicatorColor: Colors.transparent,
                      onTap: (index) {
                        tabRouter.setActiveIndex(index);

                        HapticFeedback.lightImpact();
                      },
                      tabs: [
                        TabItem(
                            isActive: tabRouter.activeIndex == 0,
                            icon: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.grey,
                            ),
                            activeIcon: Icon(
                              Icons.account_balance_wallet,
                              color: context.theme.primaryColor,
                            ),
                            label: ""),
                        GestureDetector(
                          onTap: () {
                            _showServicesBottomSheet(context);
                            HapticFeedback.lightImpact();
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: context.theme.primaryColor,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.qr_code,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        TabItem(
                            isActive: tabRouter.activeIndex == 1,
                            icon: Icon(
                              Icons.receipt,
                              color: Colors.grey,
                            ),
                            activeIcon: Icon(
                              Icons.receipt_sharp,
                              color: context.theme.primaryColor,
                            ),
                            label: "")
                      ]),
                ),
              );
            }),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.isActive,
    required this.icon,
    this.activeIcon,
    required this.label,
    this.onChanged,
  });
  final bool isActive;
  final Widget icon;
  final Widget? activeIcon;
  final String label;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (activeIcon != null && isActive) activeIcon ?? icon else icon,
        ],
      ),
    );
  }
}

void _showServicesBottomSheet(BuildContext context) {
  final countries = [
    'Deposit',
    'Transfer',
  ];
  VBottomSheetComponent.actionBottomSheet(
    context: context,
    actions: countries
        .map((country) => VBottomSheetItem(
              textColor: Colors.black,
              textWeight: FontWeight.w400,
              onTap: (context) {
                Navigator.pop(context);
              },
              title: country,
            ))
        .toList(),
  );
}
