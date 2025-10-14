import 'package:flutter/material.dart';

class CustomCircularAnimation extends StatelessWidget {
  final AnimationController? ripple1;
  final AnimationController? ripple2;
  const CustomCircularAnimation({super.key, this.ripple1, this.ripple2});

  Widget _buildPulse(
      AnimationController anim,
      double baseSize,
      double maxSize,
      Color color,
      ) {
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        final scale = Tween<double>(begin: 1.0, end: maxSize / baseSize)
            .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut))
            .value;

        final opacity = Tween<double>(begin: 0.4, end: 0.0)
            .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut))
            .value;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: baseSize,
            height: baseSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(opacity),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const baseSize = 50.0;
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildPulse(ripple2!, baseSize, 170, Color(0xFF9D476E).withOpacity(0.4)),
        _buildPulse(ripple1!, baseSize, 100, Color(0xFF9D476E).withOpacity(0.4)),
        Container(
          width: baseSize,
          height: baseSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF9D476E),
          ),
        ),
      ],
    );
  }
}
