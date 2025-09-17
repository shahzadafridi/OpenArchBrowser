import 'package:flutter/material.dart';
import '../../resources/values_manager.dart';

class SideBarControlButtonWidget extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const SideBarControlButtonWidget({
    super.key,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSize.s12,
        height: AppSize.s12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
