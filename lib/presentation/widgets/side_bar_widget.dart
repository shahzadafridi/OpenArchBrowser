import 'package:flutter/material.dart';
import 'package:open_arch_browser/presentation/widgets/side_bar_book_mark_section_wdiget.dart';
import 'package:open_arch_browser/presentation/widgets/side_bar_shortcut_wdiget.dart';
import 'package:open_arch_browser/presentation/widgets/side_bar_top_section_widget.dart';
import 'package:open_arch_browser/resources/string_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../utils/dummy_data.dart';
import '../viewmodels/bookmark_viewmodel.dart';
import '../viewmodels/recent_search_viewmodel.dart';
import '../viewmodels/tab_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import 'side_bar_bottom_section_widget.dart';
import 'side_bar_new_tab_section_widget.dart';

class SidebarWidget extends StatefulWidget {
  final VoidCallback onBackTap;
  final VoidCallback onForwardTap;
  final VoidCallback onRefresh;
  final VoidCallback onControlTap;
  final VoidCallback onAddressTap;
  final GlobalKey searchBarKey;
  final VoidCallback onNewTabTap;
  final VoidCallback onAddTap;
  final Map<String, String> siteUrls;
  final Function(String) onSiteSelected;
  final void Function(String url) onBookmarkSelected;
  final TextEditingController textEditingController;
  final BookmarkViewModel bookmarkViewModel;
  final RecentSearchViewModel recentSearchViewModel;
  final TabViewModel tabViewModel;
  final ThemeViewModel themeViewModel;

  const SidebarWidget({
    super.key,
    required this.onBackTap,
    required this.onForwardTap,
    required this.onRefresh,
    required this.onControlTap,
    required this.onAddressTap,
    required this.searchBarKey,
    required this.onNewTabTap,
    required this.onAddTap,
    required this.siteUrls,
    required this.onSiteSelected,
    required this.onBookmarkSelected,
    required this.textEditingController,
    required this.bookmarkViewModel,
    required this.recentSearchViewModel,
    required this.tabViewModel,
    required this.themeViewModel,
  });

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  String selectedSite = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s240,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s12, vertical: AppSize.s16),
      child: Column(
        children: [
          SideBarTopSectionWidget(
            onBackTap: widget.onBackTap,
            onForwardTap: widget.onForwardTap,
            onRefresh: widget.onRefresh,
            onControlTap: widget.onControlTap,
            onAddressTap: widget.onAddressTap,
            searchBarKey: widget.searchBarKey,
            textEditingController: widget.textEditingController,
          ),
          const SizedBox(height: AppSize.s24),
          SideBarBookmarksSectionWidget(
              onBookmarkSelected: widget.onBookmarkSelected),
          const SizedBox(height: AppSize.s24),
          _buildVentureDiveSection(),
          const SizedBox(height: AppSize.s24),
          SideBarNewTabSectionWidget(onTap: widget.onNewTabTap),
          const SizedBox(height: AppSize.s20),
          _buildSearchShortcuts(),
          const Spacer(),
          SideBarBottomSectionWidget(
            onAddTap: widget.onAddTap,
            onLibraryTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVentureDiveSection() {
    return Row(
      children: [
        Icon(Icons.arrow_forward_ios,
            color: ColorManager.grey, size: AppSize.s14),
        const SizedBox(width: AppSize.s8),
        Text(
          AppStrings.mySection,
          style:
              getMediumStyle(color: ColorManager.grey, fontSize: AppSize.s13),
        ),
      ],
    );
  }

  Widget _buildSearchShortcuts() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s12),
      child: Column(
        children: shortcuts.map((shortcut) {
          return Column(
            children: [
              SideBarShortcutWidget(
                title: shortcut["title"] as String,
                prefix: shortcut["prefix"] as String,
                color: shortcut["color"] as Color,
                selectedSite: selectedSite,
                // Pass the selectedSite
                onTap: (title) {
                  setState(() {
                    selectedSite = title; // Update selected site
                  });
                  widget.onSiteSelected(title);
                },
              ),
              const SizedBox(height: AppSize.s8),
            ],
          );
        }).toList(),
      ),
    );
  }
}
