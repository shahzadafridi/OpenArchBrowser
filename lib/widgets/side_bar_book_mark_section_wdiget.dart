import 'package:flutter/material.dart';

import '../resources/values_manager.dart';

class SideBarBookmarksSectionWidget extends StatefulWidget {
  const SideBarBookmarksSectionWidget({super.key});

  @override
  State<SideBarBookmarksSectionWidget> createState() =>
      _SideBarBookmarksSectionWidgetState();
}

class _SideBarBookmarksSectionWidgetState
    extends State<SideBarBookmarksSectionWidget> {
  int _selectedIndex = 2; // default selected (play_arrow)

  final List<IconData> _icons = [
    Icons.search,
    Icons.email_outlined,
    Icons.play_arrow,
  ];

  void _onBookmarkTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_icons.length, (index) {
        return Row(
          children: [
            GestureDetector(
              onTap: () => _onBookmarkTap(index),
              child: BookmarkIconWidget(
                icon: _icons[index],
                isSelected: _selectedIndex == index,
              ),
            ),
            if (index != _icons.length - 1) const SizedBox(width: AppSize.s8),
          ],
        );
      }),
    );
  }
}

class BookmarkIconWidget extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const BookmarkIconWidget({
    super.key,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? AppSize.s1_05 : AppSize.s1,
      // bigger when selected, smaller otherwise
      duration: const Duration(milliseconds: AppMilliSec.s200),
      curve: Curves.easeInOut,
      child: Container(
        width: AppSize.s65,
        height: AppSize.s45,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.2 * 255).toInt()),
          borderRadius: BorderRadius.circular(AppSize.s8),
          border: isSelected
              ? Border.all(color: Colors.red.shade300, width: AppSize.s1)
              : Border.all(color: Colors.transparent, width: AppSize.s1),
        ),
        child: Icon(icon, color: Colors.white, size: AppSize.s18),
      ),
    );
  }
}
