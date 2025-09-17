import 'package:flutter/material.dart';
import 'package:open_arch_browser/presentation/viewmodels/tab_viewmodel.dart';
import 'package:open_arch_browser/presentation/widgets/side_bar_widget.dart';
import 'package:open_arch_browser/presentation/widgets/webview_widget.dart';
import 'package:open_arch_browser/resources/string_manager.dart';
import 'package:open_arch_browser/resources/values_manager.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/dummy_data.dart';
import '../viewmodels/bookmark_viewmodel.dart';
import '../viewmodels/recent_search_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import '../widgets/arch_mini_window_widget.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({super.key});

  @override
  _BrowserScreenState createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  final GlobalKey _searchBarKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  late WebViewController webController;
  String currentUrl = AppStrings.currentUrl;
  late TextEditingController textEditingController;

  @override
  void dispose() {
    textEditingController.dispose();
    _closeMiniWindow(); // Ensure overlay is closed when disposing
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(currentUrl));
  }

  Future<void> _handleBackNavigation() async {
    if (await webController.canGoBack()) {
      webController.goBack();
    }
  }

  Future<void> _handleForwardNavigation() async {
    if (await webController.canGoForward()) {
      webController.goForward();
    }
  }

  void _toggleMiniWindow() {
    if (_overlayEntry == null) {
      _showMiniWindow();
    } else {
      _closeMiniWindow();
    }
  }

  void _showMiniWindow() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeMiniWindow() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _handleSearch(String query) {
    _closeMiniWindow(); // Close the mini window first
    textEditingController.text = "${AppStrings.googleSearchUrl}$query";
    webController.loadRequest(Uri.parse("${AppStrings.googleSearchUrl}$query"));
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox =
    _searchBarKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Invisible barrier to close overlay when tapping outside
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeMiniWindow,
              child: Container(color: Colors.transparent),
            ),
          ),
          // The actual mini window
          Positioned(
            left: offset.dx,
            top: offset.dy,
            width: 350,
            child: Material(
              color: Colors.transparent,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: AppSize.s0, end: AppSize.s1),
                duration: const Duration(milliseconds: AppMilliSec.s200),
                builder: (context, value, child) => Transform.translate(
                  offset:
                  Offset(AppSize.s0, (AppSize.s1 - value) * AppSize.s10),
                  child: Opacity(opacity: value, child: child),
                ),
                child: ArcMiniWindow(
                  onClose: _closeMiniWindow,
                  onSearch: _handleSearch,
                  recentSearches: const [
                    AppStrings.recentSearchFlutter,
                    AppStrings.recentSearchDart,
                    AppStrings.recentSearchMobile,
                    AppStrings.recentSearchState,
                    AppStrings.recentSearchApi,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFCBBFCB),
            border: Border(
              right: BorderSide(color: Color(0xFFD1D1D6), width: 0.5),
            ),
          ),
          child: Row(
            children: [
              Consumer4<BookmarkViewModel, RecentSearchViewModel, TabViewModel, ThemeViewModel>(
                builder: (context, bookmarkVM, recentSearchVM, tabVM, themeVM, _) {
                  return SidebarWidget(
                    onBackTap: _handleBackNavigation,
                    onForwardTap: _handleForwardNavigation,
                    onRefresh: () {
                      webController.reload();
                    },
                    onControlTap: () {},
                    onAddressTap: _toggleMiniWindow,
                    searchBarKey: _searchBarKey,
                    onBookmarkSelected: (url) {
                      webController.loadRequest(Uri.parse(url));
                    },
                    onNewTabTap: () {
                      setState(() {
                        currentUrl = AppStrings.defaultNewTabUrl;
                        webController.loadRequest(Uri.parse(currentUrl));
                      });
                    },
                    siteUrls: siteUrls,
                    onSiteSelected: (site) {
                      setState(() {
                        webController.loadRequest(Uri.parse(siteUrls[site]!));
                      });
                    },
                    onAddTap: () {},
                    textEditingController: textEditingController,
                    bookmarkViewModel: bookmarkVM,
                    recentSearchViewModel: recentSearchVM,
                    tabViewModel: tabVM,
                    themeViewModel: themeVM,
                  );
                },
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppSize.s10),
                  child: WebViewContainer(
                    webController: webController,
                    url: AppStrings.defaultWebViewUrl,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}