import 'package:flutter/material.dart';
import 'View/Pages.dart';
// import 'Model/Model.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/input':
        return MaterialPageRoute(builder: (_) => InputWallet());
      case '/details':
        String walletName = settings.arguments;
        return MaterialPageRoute(builder: (_) => Details(walletName));
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}.'),
            ),
          ),
        );
    }
  }
}