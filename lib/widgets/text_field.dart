import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? labelText;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? initialValue;
  final bool showPasswordToggle;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.errorText,
    this.onChanged,
    this.controller,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.onTap,
    this.labelText,
    this.labelStyle,
    this.contentPadding,
    this.fillColor,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.initialValue,
    this.showPasswordToggle = false,
    this.validator,
    this.autovalidateMode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveObscureText =
        widget.showPasswordToggle ? _obscureText : widget.obscureText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: effectiveObscureText,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onSubmitted,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          initialValue: widget.initialValue,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            suffixIcon: widget.showPasswordToggle
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.suffixIcon,
            suffixIconConstraints: widget.suffixIcon != null
                ? BoxConstraints(maxWidth: 32, maxHeight: 16)
                : null,
            errorText: widget.errorText,
            errorMaxLines: 2,
            contentPadding: widget.contentPadding,
            fillColor: widget.fillColor,
          ),
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
