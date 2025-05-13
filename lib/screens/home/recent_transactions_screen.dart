import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_app/core/res/constants.dart';

@RoutePage()
class RecentTransactionsScreen extends ConsumerWidget {
  const RecentTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(
          "No Transaction yet",
          style: title(),
        ),
      ),
    );
  }
}
