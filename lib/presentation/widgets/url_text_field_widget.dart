import 'package:flutter/material.dart';
import 'package:open_arch_browser/resources/assets_manager.dart';
import 'package:open_arch_browser/resources/string_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class UrlTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap; // optional if you want tap to open popup

  const UrlTextFieldWidget({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSize.s12),
        onTap: onTap, // 👈 trigger popup when tapped
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.2 * 255).toInt()),
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.s16,
                    vertical: AppSize.s8,
                  ),
                  child: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller,
                    builder: (context, value, _) {
                      final text = value.text;
                      return Text(
                        text.isNotEmpty ? text : AppStrings.enterUrl,
                        style: getRegularStyle(
                          color: text.isNotEmpty
                              ? ColorManager.black
                              : ColorManager.grey1,
                          fontSize: AppSize.s12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
              ),
              // Link Icon
              ImageIcon(
                AssetImage(ImageAssets.linkIcon),
                color: ColorManager.grey,
                size: AppSize.s20,
              ),
              // More Options Icon
              Container(
                margin: const EdgeInsets.only(right: AppSize.s8),
                child: ImageIcon(
                  const AssetImage(ImageAssets.moreIcon),
                  color: ColorManager.grey,
                  size: AppSize.s20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}