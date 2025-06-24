import 'package:OLIVERS/app/core/widget/progress_circle.dart';
import 'package:OLIVERS/app/export.dart'; // Assuming `ProgressCircle` is imported in export.dart

class MateriaalButtonWidget extends StatelessWidget {
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final Color? buttonBgColor;
  final Color? textColor;
  final double? buttonRadius;
  final double? minWidth;
  final double? minHeight;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Function()? onPressed;
  final double? elevation;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? widget;
  final Widget? iconWidget;
  final bool isOutlined;
  final int? isContact;
  final bool loading; // Add loading parameter

  const MateriaalButtonWidget({
    Key? key,
    this.buttonText = "",
    this.buttonBgColor,
    this.buttonTextStyle,
    this.textColor,
    this.buttonRadius,
    required this.onPressed,
    this.elevation,
    this.borderColor,
    this.borderWidth,
    this.minWidth,
    this.minHeight,
    this.verticalPadding,
    this.horizontalPadding,
    this.widget,
    this.iconWidget,
    this.isContact,
    this.isOutlined = false,
    this.loading = false, // Default loading state
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: minHeight ?? height_48,
      splashColor: Colors.transparent,
      minWidth: minWidth ?? Get.width,
      color: isOutlined ? buttonBgColor ?? Colors.white : (buttonBgColor ?? AppColors.appColor),
      elevation: elevation ?? radius_0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isOutlined ? (borderColor ?? AppColors.appColor) : Colors.transparent,
          width: isOutlined ? width_1 : width_0,
        ),
        borderRadius: BorderRadius.circular(buttonRadius ?? margin_8),
      ),
      onPressed: loading ? null : onPressed, // Disable button when loading
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding ?? margin_8,
        horizontal: horizontalPadding ?? margin_20,
      ),
      child: loading
          ? const SizedBox(
        height: 19,
        width: 19,
        child: ProgressCircle(), // Show progress circle if loading
      )
          : widget ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconWidget ?? const SizedBox(),
              TextView(
                text: buttonText!,
                textStyle: buttonTextStyle ??
                    textStyleTitleMedium().copyWith(
                      fontWeight: FontWeight.w600,
                      color: isOutlined ? textColor ?? Colors.black : (textColor ?? Colors.black),
                    ),
              ),
            ],
          ),
    );
  }
}
