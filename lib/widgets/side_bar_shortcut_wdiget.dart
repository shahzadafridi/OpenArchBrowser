import 'package:flutter/material.dart';
import 'package:open_arch_browser/resources/values_manager.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class SideBarShortcutWidget extends StatelessWidget {
  final String title;
  final String prefix;
  final Color color;
  final String selectedSite;
  final Function(String title) onTap;

  const SideBarShortcutWidget({
    super.key,
    required this.title,
    required this.prefix,
    required this.color,
    required this.selectedSite,
    required this.onTap,
  });

  bool get isSelected => title == selectedSite;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? AppSize.s1_05 : AppSize.s1,
      duration: const Duration(milliseconds: AppMilliSec.s200),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: () {
          onTap(title);
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFD1D1D6) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSize.s6),
          ),
          child: Row(
            children: [
              Container(
                width: AppSize.s28,
                height: AppSize.s28,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(AppSize.s4),
                ),
                child: prefix.isNotEmpty
                    ? Center(
                        child: Text(
                          prefix,
                          style: getRegularStyle(color: ColorManager.black, fontSize: AppSize.s12),
                        ),
                      )
                    : const Icon(Icons.play_arrow, color: Colors.white, size: AppSize.s14),
              ),
              const SizedBox(width: AppSize.s12),
              Expanded(
                child: Text(
                  title,
                  style: getRegularStyle(color: ColorManager.black, fontSize: AppSize.s12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
