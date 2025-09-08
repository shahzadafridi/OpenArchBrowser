import 'package:flutter/material.dart';
import 'package:open_arch_browser/resources/assets_manager.dart';
import 'package:open_arch_browser/resources/string_manager.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class SideBarNewTabSectionWidget extends StatelessWidget {
  final VoidCallback onTap;

  const SideBarNewTabSectionWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          ImageIcon(AssetImage(ImageAssets.plusIcon),color: ColorManager.grey, size: AppSize.s24),
          const SizedBox(width: AppSize.s8),
          Text(
            AppStrings.newTab,
            style: getMediumStyle(color: ColorManager.grey, fontSize: AppSize.s13),
          ),
        ],
      ),
    );
  }
}
