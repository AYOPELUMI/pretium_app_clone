import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RenderSvg extends StatelessWidget {
  final String svgPath;
  final double? svgHeight;
  final double? svgWidth;
  final Color? color;
  final bool useIcon;
  const RenderSvg(
      {super.key,
      required this.svgPath,
      this.svgHeight,
      this.svgWidth,
      this.useIcon = false,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: svgHeight ?? 24,
      width: svgWidth ?? 24,
      child: SvgPicture.asset(
        svgPath,
        fit: BoxFit.contain,
        height: svgHeight ?? 24,
        width: svgWidth ?? 24,
        // color: color ?? Theme.of(context).iconTheme.color,
        colorFilter: useIcon
            ? null
            : ColorFilter.mode(
                color ?? Theme.of(context).iconTheme.color!, BlendMode.srcIn),
      ),
    );
  }
}
