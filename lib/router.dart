import 'package:flutter/material.dart';
import 'view/page.dart';
// import 'Model/Model.dart';

class XRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/input':
        return MaterialPageRoute(builder: (_) => InputWalletPage());
      case '/detailswallet':
        final String walletName = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => DetailWalletPage(walletName));
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