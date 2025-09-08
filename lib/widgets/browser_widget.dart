import 'package:flutter/material.dart';
import 'package:open_arch_browser/resources/string_manager.dart';
import 'package:open_arch_browser/resources/values_manager.dart';
import 'package:open_arch_browser/widgets/side_bar_widget.dart';
import 'package:open_arch_browser/widgets/webview_widget.dart';
import 'package:open_arch_browser/widgets/arch_mini_window_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/dummy_data.dart';

class BrowserWidget extends StatefulWidget {
  const BrowserWidget({super.key});

  @override
  _BrowserWidgetState createState() => _BrowserWidgetState();
}

class _BrowserWidgetState extends State<BrowserWidget> {
  final GlobalKey _searchBarKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  late WebViewController webController;
  String currentUrl = AppStrings.currentUrl;

  @override
  void initState() {
    super.initState();
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
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox =
        _searchBarKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + renderBox.size.height + AppSize.s8,
        width: renderBox.size.width,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: AppSize.s0, end: AppSize.s1),
            duration: const Duration(milliseconds: AppMilliSec.s2000),
            builder: (context, value, child) => Transform.translate(
              offset: Offset(AppSize.s0, (AppSize.s1 - value) * AppSize.s10),
              child: Opacity(opacity: value, child: child),
            ),
            child: ArcMiniWindow(onClose: _toggleMiniWindow),
          ),
        ),
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
                    right: BorderSide(color: Color(0xFFD1D1D6), width: 0.5)),
              ),
              child: Row(
                children: [
                  SidebarWidget(
                    onBackTap: _handleBackNavigation,
                    onForwardTap: _handleForwardNavigation,
                    onCloseTap: () {
                      Navigator.of(context).maybePop();
                    },
                    onControlTap: () {
                      // Add minimize or other control behavior here
                    },
                    onAddressTap: _toggleMiniWindow,
                    searchBarKey: _searchBarKey,
                    onNewTabTap: () {
                      setState(() {
                        currentUrl = AppStrings.defaultNewTabUrl;
                        webController.loadRequest(Uri.parse(currentUrl));
                      });
                    },
                    onAddTap: () {
                      // Add behavior for adding a new item
                    },
                    webController: webController,
                    siteUrls: siteUrls,
                    onSiteSelected: (site) {
                      setState(() {
                        webController.loadRequest(Uri.parse(siteUrls[site]!));
                      });
                    },
                  ),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(AppSize.s10),
                          child:
                              WebViewContainer(webController: webController))),
                ],
              ))),
    );
  }
}
