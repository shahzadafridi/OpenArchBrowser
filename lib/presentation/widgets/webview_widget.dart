import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../resources/values_manager.dart';

class WebViewContainer extends StatefulWidget {
  final String url;
  final WebViewController webController;

  const WebViewContainer({
    super.key,
    required this.webController,
    required this.url,
  });

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  bool _hasError = false;
  String? _errorMessage;
  double _progress = 0.0; // 👈 track progress

  void safeSetState(VoidCallback fn) {
    if (!mounted) return;
    setState(fn);
  }

  @override
  void initState() {
    super.initState();

    widget.webController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint("Loading started: $url");
            safeSetState(() {
              _progress = 0;
              _hasError = false;
              _errorMessage = null;
            });
          },
          onProgress: (progress) {
            safeSetState(() {
              _progress = progress / 100.0;
            });
          },
          onPageFinished: (url) {
            debugPrint("Loading finished: $url");
            safeSetState(() {
              _progress = 1.0;
            });
          },
          onWebResourceError: (error) {
            debugPrint(
                "⚠️ WebView error: ${error.errorCode} - ${error.description}");
            debugPrint("Failing URL: ${error.url}");

            safeSetState(() {
              _hasError = true;
              _errorMessage = error.description;
              _progress = 0;
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
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        child: Stack(
          children: [
            _hasError
                ? _buildErrorScreen()
                : WebViewWidget(controller: widget.webController),

            // Gradient progress bar
            if (_progress < 1.0 && !_hasError)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Colors.purpleAccent,
                      ],
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    );
                  },
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 4,
                    backgroundColor: Colors.transparent,
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
          ],
        ),
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
              safeSetState(() {
                _hasError = false;
                _errorMessage = null;
                _progress = 0;
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