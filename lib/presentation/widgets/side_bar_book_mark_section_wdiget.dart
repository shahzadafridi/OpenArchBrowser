import 'package:flutter/material.dart';
import '../../resources/values_manager.dart';

class SideBarBookmarksSectionWidget extends StatefulWidget {
  /// Callback when a bookmark is tapped
  final void Function(String url) onBookmarkSelected;

  const SideBarBookmarksSectionWidget({
    super.key,
    required this.onBookmarkSelected,
  });

  @override
  State<SideBarBookmarksSectionWidget> createState() =>
      _SideBarBookmarksSectionWidgetState();
}

class _SideBarBookmarksSectionWidgetState
    extends State<SideBarBookmarksSectionWidget> {
  int _selectedIndex = 2; // default selected (play_arrow)

  /// Each bookmark = icon + url
  final List<Map<String, dynamic>> _bookmarks = [
    {"icon": Icons.search, "url": "https://google.com"},
    {"icon": Icons.email_outlined, "url": "https://mail.google.com"},
    {"icon": Icons.play_arrow, "url": "https://youtube.com"},
  ];

  void _onBookmarkTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // fire callback with url
    widget.onBookmarkSelected(_bookmarks[index]["url"]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_bookmarks.length, (index) {
        return Row(
          children: [
            GestureDetector(
              onTap: () => _onBookmarkTap(index),
              child: BookmarkIconWidget(
                icon: _bookmarks[index]["icon"],
                isSelected: _selectedIndex == index,
              ),
            ),
            if (index != _bookmarks.length - 1)
              const SizedBox(width: AppSize.s8),
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