import 'package:flutter/material.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class SideBarNavigationButtonWidget extends StatelessWidget {
  final AssetImage icon;
  final bool isEnabled;
  final VoidCallback onTap;

  const SideBarNavigationButtonWidget({
    super.key,
    required this.icon,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppSize.s24,
        height: AppSize.s24,
        child: ImageIcon(
          icon,
          color: ColorManager.grey,
          size: AppSize.s12,
        ),
      ),
    );
  }
}
