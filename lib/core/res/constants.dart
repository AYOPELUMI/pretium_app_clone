import 'package:flutter/material.dart';
import 'package:pretium_app/core/res/theme.dart';
import 'package:sizer/sizer.dart';

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

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

Widget textBelow(
    {required Function() onTap,
    required BuildContext context,
    required String description,
    required String actonWord}) {
  return Center(
    child: Text.rich(
      TextSpan(
        text: description,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.sp,
        ),
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                actonWord,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
