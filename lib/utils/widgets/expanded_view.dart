part of 'widgets.dart';

class ExpandedView2Row extends StatelessWidget {
  final int flex1, flex2;
  final Widget child1, child2;
  const ExpandedView2Row({
    super.key,
    required this.flex1,
    required this.flex2,
    required this.child1,
    required this.child2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: flex1,
          child: child1,
        ),
        const HorizontalGap15(),
        Expanded(
          flex: flex2 - 15,
          child: Align(
            alignment: Alignment.topRight,
            child: child2,
          ),
        ),
      ],
    );
  }
}
