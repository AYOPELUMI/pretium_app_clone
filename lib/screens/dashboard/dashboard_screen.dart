// lib/features/dashboard/dashboard_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_app/core/res/colors.dart';
import 'package:pretium_app/core/res/gap.dart';
import 'package:pretium_app/core/res/theme.dart';
import 'package:sizer/sizer.dart';

import '../../core/providers/auth_provider.dart';

@RoutePage()
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: context.theme.primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Text(
              "O",
              style: TextStyle(
                  backgroundColor: Colors.white,
                  color: context.theme.primaryColor,
                  fontSize: 16.sp),
            ),
          ),
        ),
        title: Text(
          'Hello, ${user?['firstName']}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet Balance Card
              Container(
                decoration: BoxDecoration(
                  color: context.theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.verticalSpacing,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: PretiumColors.lightprimaryColor,
                                shape: BoxShape.rectangle),
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: PretiumColors.lightprimaryColor,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.visibility,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                      Text(
                        'Wallet Balance',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300),
                      ),
                      14.verticalSpacing,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NGN ",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' 0.00',
                            style: TextStyle(
                                fontSize: 23.sp,
                                height: 1,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      6.verticalSpacing,
                      IntrinsicWidth(
                        child: TextButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 7),
                              minimumSize: Size(double.infinity, 25),
                              backgroundColor: PretiumColors.lightprimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              '\$ 0.00',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                padding: EdgeInsets.fromLTRB(12, 14, 12, 8),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Financial Services',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              'Nigeria',
                              style: TextStyle(
                                  color: context.theme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp),
                            ),
                            3.horizontalSpacing,
                            Icon(Icons.keyboard_arrow_down,
                                size: 12, color: context.theme.primaryColor),
                          ],
                        ),
                      ],
                    ),

                    // Services Grid (1:1 ratio)
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 1.4, // Maintain 1:1 ratio
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: [
                        _buildServiceItem('Opay', Icons.account_balance_wallet),
                        _buildServiceItem('Moniepoint', Icons.money),
                        _buildServiceItem('PalmPay', Icons.payment),
                        _buildServiceItem('Airtime', Icons.phone_android),
                      ],
                    ),
                  ],
                ),
              ),

              10.verticalSpacing,
              // Recent Transactions Section
              Row(
                children: [
                  Text(
                    'Recent transactions',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(
                          color: context.theme.primaryColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Center(
                      child: Text(
                        'No recent transactions',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(String name, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18,
              color: Colors.blue,
            ),
          ),
          4.verticalSpacing,
          Text(
            name,
            style: TextStyle(
                fontSize: 10.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
