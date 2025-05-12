import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

TextStyle subText() {
  return TextStyle(fontSize: 12.sp, color: Colors.grey);
}

TextStyle title() {
  return TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
  );
}

Widget SkipWidget({required Function() onTap}) {
  return Align(
    alignment: Alignment.topRight,
    child: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: const Text(
          'Skip',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
