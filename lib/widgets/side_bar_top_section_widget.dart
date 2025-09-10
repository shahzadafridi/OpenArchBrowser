import 'package:flutter/material.dart';
import 'package:open_arch_browser/resources/assets_manager.dart';
import 'package:open_arch_browser/resources/values_manager.dart';
import 'package:open_arch_browser/widgets/url_text_field_widget.dart';
import 'side_bar_control_button_widget.dart';
import 'side_bar_navigation_button_widget.dart';

class SideBarTopSectionWidget extends StatefulWidget {
  final VoidCallback onBackTap;
  final VoidCallback onForwardTap;
  final VoidCallback onRefresh;
  final VoidCallback onControlTap;
  final VoidCallback onAddressTap; // 👈 NEW: to toggle mini window
  final TextEditingController textEditingController;
  final GlobalKey searchBarKey; // 👈 NEW: to anchor mini window

  const SideBarTopSectionWidget({
    super.key,
    required this.onBackTap,
    required this.onForwardTap,
    required this.onRefresh,
    required this.onControlTap,
    required this.onAddressTap,
    required this.textEditingController,
    required this.searchBarKey,
  });

  @override
  _SideBarTopSectionWidgetState createState() =>
      _SideBarTopSectionWidgetState();
}

class _SideBarTopSectionWidgetState extends State<SideBarTopSectionWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Browser Controls
        Row(
          children: [
            SideBarNavigationButtonWidget(
              icon: AssetImage(ImageAssets.menuIcon),
              isEnabled: false,
              onTap: widget.onBackTap,
            ),
            Spacer(),
            SideBarNavigationButtonWidget(
              icon: AssetImage(ImageAssets.arrowBack),
              isEnabled: false,
              onTap: widget.onBackTap,
            ),
            const SizedBox(width: AppSize.s8),
            SideBarNavigationButtonWidget(
              icon: AssetImage(ImageAssets.arrowForward),
              isEnabled: false,
              onTap: widget.onForwardTap,
            ),
            const SizedBox(width: AppSize.s8),
            SideBarNavigationButtonWidget(
              icon: AssetImage(ImageAssets.refresh),
              isEnabled: true,
              onTap: widget.onRefresh,
            ),
          ],
        ),

        const SizedBox(height: AppSize.s32),

        // Address Bar (click to toggle mini window)
        GestureDetector(
          child: SizedBox(
            key: widget.searchBarKey,
            height: AppSize.s38,
            child: UrlTextFieldWidget(controller: widget.textEditingController, onTap: widget.onAddressTap),
          ),
        ),
      ],
    );
  }
}
