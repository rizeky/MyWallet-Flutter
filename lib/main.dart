import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show MultiProvider, ChangeNotifierProvider, FutureProvider;
import 'Controller/Controller.dart';
import 'route.dart';

Future<void> main() async => runApp(MyApp());

class MyApp extends StatelessWidget {

  final String _title = "Uang Ku";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Controller>(create: (_) => new Controller()),
        FutureProvider<void>(create: (_) => Controller().loadWallets(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => child,
        title: this._title,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF6200EE),
          accentColor: Color(0xFF03DAC5),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}


