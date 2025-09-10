import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../resources/values_manager.dart';

class WebViewContainer extends StatefulWidget {
  final String url;
  final WebViewController webController;

  const WebViewContainer({super.key, required this.webController, required this.url});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    widget.webController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint("Loading started: $url");
            setState(() {
              _hasError = false;
              _errorMessage = null;
            });
          },
          onPageFinished: (url) {
            debugPrint("Loading finished: $url");
          },
          onWebResourceError: (error) {
            debugPrint(
                "⚠️ WebView error: ${error.errorCode} - ${error.description}");
            debugPrint("Failing URL: ${error.url}");

            setState(() {
              _hasError = true;
              _errorMessage = error.description;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    // ❌ macOS doesn't support setBackgroundColor (throws UnimplementedError)
    if (!Platform.isMacOS) {
      widget.webController.setBackgroundColor(Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
        child: _hasError
            ? _buildErrorScreen()
            : WebViewWidget(controller: widget.webController),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(
            "Failed to load page",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _hasError = false;
                _errorMessage = null;
              });
              widget.webController.loadRequest(Uri.parse(widget.url));
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
