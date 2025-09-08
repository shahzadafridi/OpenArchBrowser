import 'package:open_arch_browser/resources/string_manager.dart';
import 'package:open_arch_browser/widgets/browser_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


class Routes {
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const BrowserWidget());
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(AppStrings.noRouteFound.tr())),
        body: Center(
          child: Text(AppStrings.noRouteFound.tr()),
        ),
      ),
    );
  }
}