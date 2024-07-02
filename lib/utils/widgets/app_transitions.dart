import 'package:flutter/material.dart';

class AppTransitions extends StatelessWidget {
  final Widget child;
  const AppTransitions({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: child,
    );
  }
}
