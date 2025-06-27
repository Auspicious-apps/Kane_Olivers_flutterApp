import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;

  const ShimmerWidget({
    Key? key,
    required this.child,
    required this.enabled,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      // baseColor: baseColor ?? Colors.grey[300]!,
      // highlightColor: highlightColor ?? Colors.grey[100]!,
      // duration: duration,
      child: child,
    );
  }
}

// Custom shimmer containers for common UI elements
class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color? color;

  const ShimmerContainer({
    Key? key,
    this.width = double.infinity,
    this.height = 20,
    this.borderRadius = 8,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[300],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class ShimmerText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;

  const ShimmerText({
    Key? key,
    required this.text,
    this.style,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: maxLines,
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  final double size;
  final Color? color;

  const ShimmerCircle({
    Key? key,
    this.size = 40,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const ShimmerCard({
    Key? key,
    this.width = double.infinity,
    this.height = 100,
    this.borderRadius = 12,
    this.margin,
    this.padding,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
} 