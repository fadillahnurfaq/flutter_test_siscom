part of "widgets.dart";

class ColumnFormField extends StatelessWidget {
  final String text;
  final String? initialValue;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final void Function(String)? onSubmit;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? focusNode;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? suffixText;
  final EdgeInsetsGeometry? contentPadding;
  final Color? focusColor;
  final Color? fillColor;
  final bool? readOnly;
  final bool obscureText;
  final TextInputAction? styleTextInputAction;
  final TextInputType? keyboardType;
  final bool isDigitsAndDotsOnly;
  final bool isNumberOnly;
  final bool isLowerCase;
  final bool isCurrency;
  final Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;

  const ColumnFormField({
    super.key,
    required this.text,
    this.initialValue,
    this.controller,
    this.onTap,
    this.onSubmit,
    this.onSaved,
    this.validator,
    this.prefix,
    this.suffix,
    this.isDigitsAndDotsOnly = false,
    this.isNumberOnly = false,
    this.isLowerCase = false,
    this.isCurrency = false,
    this.obscureText = false,
    this.maxLines,
    this.maxLength,
    this.keyboardType,
    this.hintText,
    this.hintStyle,
    this.suffixText,
    this.contentPadding,
    this.focusNode,
    this.focusColor,
    this.fillColor,
    this.readOnly,
    this.styleTextInputAction,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLabel(text: text),
        const VerticalGap5(),
        CustomFormField(
          initialValue: initialValue,
          readOnly: readOnly ?? false,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          onTap: onTap,
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          styleTextInputAction: styleTextInputAction ?? TextInputAction.next,
          keyboardType: keyboardType,
          onChanged: onChanged,
          onSubmit: onSubmit,
          onSaved: onSaved,
          obscureText: obscureText,
          isDigitsAndDotsOnly: isDigitsAndDotsOnly,
          isNumberOnly: isNumberOnly,
          isCurrency: isCurrency,
          isLowerCase: isLowerCase,
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                fontSize: 15.0,
                fontWeight: AppTextStyle.regular,
                color: AppColors.grey,
              ),
          suffixText: suffixText,
          contentPadding: contentPadding ?? const EdgeInsets.all(10),
          prefix: prefix,
          suffix: suffix,
          fillColor: fillColor,
          focusColor: focusColor,
        ),
      ],
    );
  }
}
