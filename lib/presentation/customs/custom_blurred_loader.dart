import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_reg/statics/app_colors.dart';

class BlurredLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const BlurredLoader({Key? key, required this.isLoading, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Stack(
      children: [
        child,
        //
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              color: Colors.black.withValues(alpha: 0.3), //
            ),
          ),
        ),
        //
        const Center(child: CircularProgressIndicator(color: AppColors.darkGray)),
      ],
    );
  }
}
