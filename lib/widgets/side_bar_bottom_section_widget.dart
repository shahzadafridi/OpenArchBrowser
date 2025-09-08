import 'package:flutter/material.dart';
import 'package:open_arch_browser/resources/assets_manager.dart';
import 'package:open_arch_browser/resources/values_manager.dart';

import '../resources/color_manager.dart';

class SideBarBottomSectionWidget extends StatelessWidget {
  final VoidCallback onAddTap;
  final VoidCallback onLibraryTap;

  const SideBarBottomSectionWidget({super.key, required this.onAddTap, required this.onLibraryTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: onLibraryTap,
            child: ImageIcon(
              AssetImage(ImageAssets.libraryIcon),
              color: ColorManager.grey,
              size: AppSize.s24,
            )
        ),
        const Spacer(),
        GestureDetector(
            onTap: onAddTap,
            child: ImageIcon(
              AssetImage(ImageAssets.plusIcon),
              color: ColorManager.grey,
              size: AppSize.s24,
            ),
        ),
      ],
    );
  }
}
