// lib/features/auth/screens/verify_account_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_app/core/res/constants.dart';
import 'package:pretium_app/core/res/gap.dart';
import 'package:pretium_app/core/res/images.dart';
import 'package:pretium_app/core/router/router.gr.dart';
import 'package:pretium_app/screens/auth/login.dart';
import 'package:pretium_app/widgets/render_svg.dart';

import '../../widgets/bottom_sheet.dart';
import '../../widgets/text_field.dart';
import 'pin_confirmation_screen.dart';

@RoutePage()
class VerifyAccountScreen extends ConsumerStatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  ConsumerState<VerifyAccountScreen> createState() =>
      _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends ConsumerState<VerifyAccountScreen> {
  final _codeController = TextEditingController();
  String? _selectedCountry;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _showCountryBottomSheet(BuildContext context) {
    final countries = [
      'Kenya',
      'Uganda',
      'Nigeria',
      'Ghana',
      'Malawi',
      'Zambia',
      'Rwanda'
    ];
    VBottomSheetComponent.actionBottomSheet(
      context: context,
      customHeader: const Text(
        'Select Country',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      actions: countries
          .map((country) => VBottomSheetItem(
                textColor: Colors.black,
                textWeight: FontWeight.w400,
                onTap: (context) {
                  setState(() {
                    _selectedCountry = country;
                  });
                  Navigator.pop(context);
                },
                title: country,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => context.router.popForced(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Verify Account',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Enter the verification code sent to your email',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () => _showCountryBottomSheet(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedCountry ?? 'Select Country',
                      style: TextStyle(
                        color: _selectedCountry != null
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _codeController,
              hintText: '1234',
              labelText: '1234',
              suffixIcon: Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: RenderSvg(
                      svgPath: PretiumImages.shield_svg,
                      useIcon: true,
                    ),
                  ),
                  16.horizontalSpacing
                ],
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_codeController.text.isEmpty ||
                      _selectedCountry == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }
                  context.router.push(PinConfirmationRoute());
                },
                child: const Text('Verify Account'),
              ),
            ),
            32.verticalSpacing,
            textBelow(
                onTap: () {},
                context: context,
                description: "Didnt receive the code?  ",
                actonWord: "Resend Code")
          ],
        ),
      ),
    );
  }
}
