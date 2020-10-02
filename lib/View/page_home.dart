part of 'page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XTopBar(
        textTitle: "",
        leading: const Icon(Icons.account_balance_wallet),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, '/input'),
        ),  
      ),
      body: Center(),
    );
  }
}
