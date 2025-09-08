import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../resources/values_manager.dart';

class WebViewContainer extends StatelessWidget {
  final WebViewController webController;

  const WebViewContainer({super.key, required this.webController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s8),
          topRight: Radius.circular(AppSize.s8),
          bottomLeft: Radius.circular(AppSize.s8),
          bottomRight: Radius.circular(AppSize.s8),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s8),
          topRight: Radius.circular(AppSize.s8),
          bottomLeft: Radius.circular(AppSize.s8),
          bottomRight: Radius.circular(AppSize.s8),
        ),
        child: WebViewWidget(controller: webController),
      ),
    );
  }
}
