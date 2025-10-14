import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class PrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? color;
  final Color? borderColor;
  final String title;
  final TextStyle? textStyle;
  final Function() onTap;

  const PrimaryButton({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.color,
    required this.title,
    required this.onTap,
    this.textStyle,
    this.borderColor,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0,
          vertical: verticalPadding ?? 10,
        ),
        height: height ?? 50,
        width: width ?? MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 18),
          color: color ?? Color(0xFF9D476E),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle ?? GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}