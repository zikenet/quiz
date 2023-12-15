import 'package:flutter/material.dart';

enum TextStyleEnum {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
}

class SimpleText extends StatelessWidget {
  const SimpleText(
    this.text, {
    super.key,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.color,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.overflow,
  });

  final String text;
  final TextStyleEnum? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final Color? color;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final style = _buildStyle(context);
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: style,
    );
  }

  _buildStyle(BuildContext context) {
    switch (textStyle) {
      case TextStyleEnum.headlineLarge:
        return Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              height: height,
            );
      case TextStyleEnum.headlineMedium:
        return Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              height: height,
            );
      case TextStyleEnum.headlineSmall:
        return Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              height: height,
            );
      case TextStyleEnum.titleLarge:
        return Theme.of(context).textTheme.titleLarge!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              height: height,
            );
      case TextStyleEnum.titleMedium:
        return Theme.of(context).textTheme.titleMedium!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              height: height,
            );
      case TextStyleEnum.titleSmall:
        return Theme.of(context).textTheme.titleSmall!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              height: height,
            );
      case TextStyleEnum.bodyLarge:
        return Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              height: height,
            );
      case TextStyleEnum.bodyMedium:
        return Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              height: height,
            );

      case TextStyleEnum.bodySmall:
        return Theme.of(context).textTheme.bodySmall!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              height: height,
            );

      default:
        return Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              height: height,
            );
    }
  }
}
