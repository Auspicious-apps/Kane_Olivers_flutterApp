import 'package:OLIVERS/app/core/widget/intl_phone_field/phone_number.dart';
import 'package:OLIVERS/app/core/widget/intl_phone_field/phone_number.dart';


import '../../../export.dart'hide EmailTextInputFormatter;

import '../custom_text_field.dart';
import 'countries.dart';
import 'intl_phone_field.dart';


class CountryPickerTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final GlobalKey<IntlPhoneFieldState>? pickerKey;
  final String? hintText;
  final String? labelText;
  final TextStyle? inputTextStyle;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final double? contentPadding;
  final double? borderRadius;
  final bool showShadow;
  final bool showCountryFlag;
  final bool readOnly;
  final Widget? suffix;
  final Rx<Country> selectedCountry;
  final ValueChanged<Country>? onCountryChanged;
  final Function(PhoneNumber value)? onChanged;
  final bool showBorder;

  final double? borderWidth;
  final Color? borderColor;

  const CountryPickerTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.pickerKey,
      this.labelText,
      this.inputTextStyle,
      this.contentPadding,
      this.onChanged,
      this.borderRadius,
      this.inputType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.showShadow = false,
      this.showCountryFlag = false,
      this.readOnly = false,
      this.suffix,
      this.focusNode,
      required this.selectedCountry,
      required this.onCountryChanged,
      this.borderColor,
      this.showBorder = true,
      this.borderWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: labelText != null,
          child: TextView(
                  text: labelText ?? "",
            textStyle:  Theme.of(Get.context!).textTheme.displayMedium!.copyWith(
              color: AppColors.whiteColor,
              fontSize: 16 ,
              fontFamily: "TOMMYSOFT",
            ), )
              .paddingOnly(bottom: margin_14),
        ),
        Theme(
          data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                  selectionColor: AppColors.appColor.withOpacity(0.4))),
          child: AbsorbPointer(
            absorbing: readOnly,
            child: IntlPhoneField(

              controller: controller,
              focusNode: focusNode,
              key: pickerKey,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputAction: textInputAction,
              invalidNumberMessage: "Invalid Number",
              emptyFieldMessage: "Please Enter Your Number",
              decoration: _inputDecoration(),
              dropdownTextStyle: textStyleTitleSmall(),
              showCountryFlag:true,



              dropdownIcon: Icon(Icons.arrow_drop_down,color: Colors.grey,size: 20,),
              onChanged: onChanged,
              style: inputTextStyle ??
                  textStyleTitleMedium()
                      .copyWith(fontWeight: FontWeight.w900, color:Colors.white,fontSize: font_14,fontFamily: "Mulish"),
              initialSelectedCountry: selectedCountry,
              dropdownIconPosition: IconPosition.leading,
              onCountryChanged: onCountryChanged,
              autovalidateMode: AutovalidateMode.onUnfocus,

            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      fillColor:Color.fromRGBO(24, 34, 38, 1),
      filled: true,


      contentPadding: EdgeInsets.symmetric(
          vertical: margin_10, horizontal:  margin_12),
      errorMaxLines: 3,
      counterText: '',
      border: !showBorder
          ? InputBorder.none
          :      OutlineInputBorder(
          borderRadius: BorderRadius.circular( radius_50),
          borderSide: BorderSide(color: (Colors.transparent))),

        focusedBorder:!showBorder
            ? InputBorder.none
            :   OutlineInputBorder(
            borderRadius: BorderRadius.circular( radius_50),
            borderSide:BorderSide(color: ( Colors.yellow))),

      disabledBorder: !showBorder
          ? InputBorder.none
          : OutlineInputBorder(
          borderRadius: BorderRadius.circular( radius_50),
          borderSide: BorderSide(color: Colors.transparent))
        ,
      enabledBorder: !showBorder
          ? InputBorder.none
          : OutlineInputBorder(
          borderRadius: BorderRadius.circular( radius_50),
          borderSide: BorderSide(color: Colors.transparent))
      ,
      focusedErrorBorder: !showBorder
          ? InputBorder.none
          : OutlineInputBorder(
          borderRadius: BorderRadius.circular( radius_50),
          borderSide: BorderSide(color: Colors.transparent))
      ,
      errorBorder: !showBorder
          ? InputBorder.none
          : OutlineInputBorder(
          borderRadius: BorderRadius.circular( radius_50),
          borderSide: BorderSide(color: AppColors.redColor))
      ,
      hintText: hintText?.tr,
      hintStyle:
textStyleTitleMedium()
        .copyWith(fontWeight: FontWeight.w500, color:AppColors.smallTextColor,fontSize: font_13,fontFamily: "Mulish"),
      suffixIcon: suffix,
    );
  }
}
