part of "widgets.dart";

class CustomButton extends StatelessWidget {
  final double? height, width;
  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final Color? backgroundColor;
  final double? radius;
  final TextStyle? textStyle;
  const CustomButton({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
    this.backgroundColor,
    this.radius,
    this.height,
    this.width,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 30.0),
          ),
        ),
        onPressed: onPressed,
        child: child ??
            TextLabel(
              align: TextAlign.center,
              text: text ?? "",
              textStyle: textStyle ??
                  AppTextStyle.h4.copyWith(
                    color: AppColors.backgroundcolor,
                  ),
            ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final double? height, width;
  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final Color? backgroundColor;
  final double? radius;
  final TextStyle? textStyle;
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
    this.backgroundColor,
    this.radius,
    this.height,
    this.width,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10.0)),
          side: BorderSide(
            width: 1.0,
            color: backgroundColor ?? AppColors.primary,
            style: BorderStyle.solid,
          ),
        ),
        onPressed: onPressed,
        child: child ??
            TextLabel(
              align: TextAlign.center,
              text: text ?? "",
              textStyle: textStyle ??
                  AppTextStyle.h4.copyWith(
                    color: AppColors.black,
                  ),
            ),
      ),
    );
  }
}
