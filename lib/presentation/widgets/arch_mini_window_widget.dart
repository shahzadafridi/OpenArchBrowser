import 'dart:async';
import 'package:flutter/material.dart';
import 'package:open_arch_browser/model/RecentSearchModel.dart';
import 'package:open_arch_browser/resources/color_manager.dart';
import 'package:open_arch_browser/resources/string_manager.dart';
import 'package:open_arch_browser/resources/values_manager.dart';

import '../../utils/dummy_data.dart';

class ArcMiniWindow extends StatefulWidget {
  final VoidCallback onClose;
  final ValueChanged<String> onSearch; // when user presses submit/arrow
  final ValueChanged<String> onChangeValue; // when typing (debounced)
  final List<RecentSearchModel> recentSearches;

  const ArcMiniWindow({
    super.key,
    required this.onClose,
    required this.onSearch,
    required this.onChangeValue,
    this.recentSearches = const [],
  });

  @override
  State<ArcMiniWindow> createState() => _ArcMiniWindowState();
}

class _ArcMiniWindowState extends State<ArcMiniWindow> {
  final TextEditingController _controller = TextEditingController();
  final Duration _debounceDuration = const Duration(milliseconds: 300);

  Timer? _debounce;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });
  }

  void _onSubmit() {
    if (_controller.text.isNotEmpty) {
      widget.onSearch(_controller.text);
    }
  }

  void _onRecentSearchTap(String searchText) {
    _controller.text = searchText;
    setState(() {
      _hasText = searchText.isNotEmpty;
    });
    _onSubmit();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () {
      widget.onChangeValue(value);
    });
  }

  List<String> get _displaySearches {
    return widget.recentSearches.isNotEmpty
        ? widget.recentSearches.map((e) => e.query).take(8).toList()
        : dummyRecentSearches.map((e) => e.query).take(6).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: AppSize.s12,
            offset: Offset(AppSize.s0, AppSize.s4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: AppStrings.searchHint,
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _onSubmit(),
                    onChanged: _onChanged, // debounced handler
                  ),
                ),
                IconButton(
                  icon: Icon(_hasText ? Icons.arrow_forward : Icons.clear),
                  onPressed: () {
                    if (_hasText) {
                      _onSubmit();
                    } else {
                      widget.onClose();
                    }
                  },
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
            child: Divider(height: 1),
          ),

          // Recent searches
          if (_displaySearches.isNotEmpty)
            Container(
              constraints: const BoxConstraints(maxHeight: AppSize.s300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        AppSize.s16, AppSize.s12, AppSize.s16, AppSize.s8),
                    child: Row(
                      children: [
                        Icon(Icons.history,
                            size: AppSize.s18, color: ColorManager.lightGrey),
                        const SizedBox(width: AppSize.s8),
                        Text(
                          'Recent Searches',
                          style: TextStyle(
                            fontSize: AppSize.s14,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.grey,
                          ),
                        ),
                        if (widget.recentSearches.isEmpty)
                          Container(
                            margin: const EdgeInsets.only(left: AppSize.s8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.s6, vertical: AppSize.s2),
                            decoration: BoxDecoration(
                              color: ColorManager.orangeLight,
                              borderRadius: BorderRadius.circular(AppSize.s8),
                            ),
                            child: Text(
                              AppStrings.new_label,
                              style: TextStyle(
                                fontSize: AppSize.s10,
                                color: ColorManager.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // List
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _displaySearches.length,
                      itemBuilder: (context, index) {
                        final search = _displaySearches[index];
                        return InkWell(
                          onTap: () => _onRecentSearchTap(search),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSize.s16,
                              vertical: AppSize.s8,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.history,
                                    size: AppSize.s16,
                                    color: ColorManager.grey),
                                const SizedBox(width: AppSize.s12),
                                Expanded(
                                  child: Text(
                                    search,
                                    style: const TextStyle(fontSize: AppSize.s14),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(Icons.north_west,
                                    size: AppSize.s14,
                                    color: ColorManager.lightGrey),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }
}