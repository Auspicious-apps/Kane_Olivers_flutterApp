
import '../../export.dart';




class TextFieldWidget extends StatelessWidget {

  final String? hint;
  final String? tvHeading;

  final Color? fillColor;
  final Color? courserColor;
  final Color? borderColor;

  final validate;
  final hintStyle;
  final style;
  final EdgeInsets? contentPadding;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputAction? inputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final int? maxLines;
  final decoration;
  final int? minLine;
  final int? maxLength;
  final double? borderRadius;
  final bool readOnly;
  final bool? obscureText;
  final suffixIconConstraints;
  final Function(String value)? onChange;
  final List<TextInputFormatter>? formatter;

  TextFieldWidget({super.key,
    this.hint,
    this.tvHeading,
    this.inputType,
    this.textController,
    this.hintStyle,
    this.style,
    this.courserColor,
    this.validate,
    this.onChange,
    this.decoration,
    this.focusNode,
    this.prefix,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.formatter,
    this.inputAction,
    this.contentPadding,
    this.maxLines ,
    this.minLine ,
    this.maxLength,
    this.borderRadius,
    this.borderColor,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconConstraints,
    this.obscureText,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
      children: [
        tvHeading != null
            ? TextView(
          text: tvHeading,
          textStyle:  Theme.of(Get.context!).textTheme.displayMedium!.copyWith(
              color: AppColors.whiteColor,
              fontSize: 16 ,
              fontFamily: "TOMMYSOFT",

            ),
        ).marginOnly(bottom: margin_10,left: margin_5)
            : SizedBox(height: 0),

        Theme(data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
                selectionColor:AppColors.backgroundColor.withOpacity(0.4))), child:
        TextFormField(

            readOnly: readOnly,
            onTap: onTap,

            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscureText ?? false,
            controller: textController,
            focusNode: focusNode,
            keyboardType: inputType,

            maxLength: maxLength,
            onChanged: onChange,
            cursorColor: courserColor ?? AppColors.appBorderDarkColor,
            inputFormatters: formatter ,
            maxLines: maxLines ?? 1,
            minLines: minLine ?? 1,
            obscuringCharacter: "*",
            textInputAction: inputAction,
            onFieldSubmitted: onFieldSubmitted,


            validator: validate,
            style:style?? textStyleTitleMedium()
                .copyWith(fontWeight: FontWeight.w400, color:Colors.white,fontSize: font_14,fontFamily: "Mulish"),
            decoration: inputDecoration())
        )
      ],


    );
  }

  inputDecoration() =>  InputDecoration(
    errorMaxLines: 3,
    hoverColor: AppColors.appBorderDarkColor,

    filled: true,
    isCollapsed: true,
    isDense: true,
    counterText: '',
    contentPadding: contentPadding ??
        EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_13),
    prefixIcon: prefixIcon,
    prefixIconConstraints: BoxConstraints(maxWidth: margin_100,minWidth: margin_30),
    prefix: prefix,
    suffixIcon: suffixIcon,
    suffixIconConstraints: BoxConstraints(maxWidth: margin_100,minWidth: margin_30) ,
    hintText: hint,
    hintStyle: hintStyle ??
        textStyleBodyMedium()
            .copyWith(color: Colors.grey.shade600,fontSize: font_14,fontFamily: "Mulish"),
    labelText: "",
    floatingLabelBehavior: FloatingLabelBehavior.always,
    fillColor: fillColor ?? (AppColors.backgroundColor),

    border: decoration ??
        OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius??  radius_10),
            borderSide: BorderSide(color: (borderColor?? Colors.transparent))),
    focusedErrorBorder: decoration ??  OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius?? radius_10),
        borderSide:BorderSide(color: (borderColor?? Colors.transparent))),
    errorBorder: decoration ?? OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius?? radius_10),
        borderSide:BorderSide(color: (borderColor?? Colors.red))),
    focusedBorder: decoration ??  OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius?? radius_10),
        borderSide:BorderSide(color: (borderColor?? Colors.yellow))),
    enabledBorder: decoration ??  OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius?? radius_10),
        borderSide: BorderSide(color: (borderColor?? Colors.transparent))),
  );
}



class EmailTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow only valid email characters
    final filteredValue = newValue.text.replaceAll(RegExp(r'[^A-Za-z0-9@._-]'), '');

    return TextEditingValue(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}
