import 'package:flutter/material.dart';
import 'package:open_arch_browser/resources/assets_manager.dart';
import 'package:open_arch_browser/resources/string_manager.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class UrlTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const UrlTextFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.2 * 255).toInt()),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                // Wrap TextFormField with Center
                child: TextField(
                  controller: controller,
                  style: getRegularStyle(color: ColorManager.black, fontSize: AppSize.s12),
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s16,
                      vertical: AppSize.s0,
                    ),
                    hintText: AppStrings.enterUrl,
                    hintStyle:getRegularStyle(color: ColorManager.grey1, fontSize: AppSize.s12),
                    isDense: true,
                  ),
                ),
              ),
            ),
            // Link Icon
            Container(
              child: ImageIcon(AssetImage(ImageAssets.linkIcon), color: ColorManager.grey, size: AppSize.s20),
            ),
            // More Options Icon
            Container(
              margin: const EdgeInsets.only(right: AppSize.s8),
              child: ImageIcon(const AssetImage(ImageAssets.moreIcon), color: ColorManager.grey,  size: AppSize.s20),
            ),
          ],
        ),
      ),
    );
  }
}
