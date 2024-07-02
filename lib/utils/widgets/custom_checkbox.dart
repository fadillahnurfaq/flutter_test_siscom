part of "widgets.dart";

class CustomCheckBox extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool value;
  final Widget? content;
  final Color? color;
  const CustomCheckBox(
      {super.key,
      required this.onPressed,
      this.content,
      this.value = false,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: value ? color ?? AppColors.primary : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(
                    width: 1.5,
                    color: !value ? AppColors.grey : Colors.transparent),
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  size: 14,
                  color: value ? Colors.white : Colors.transparent,
                ),
              ),
            ),
            if (content != null) ...[const HorizontalGap10(), content!],
          ],
        ),
      ),
    );
  }
}
