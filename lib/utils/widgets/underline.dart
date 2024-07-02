part of 'widgets.dart';

class Underline extends StatelessWidget {
  final double? width, thickness;
  final Color? color;
  const Underline({
    super.key,
    this.width,
    this.thickness,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 150.0,
      child: Divider(
        color: color ?? AppColors.grey2,
        thickness: thickness ?? 1.0,
      ),
    );
  }
}
