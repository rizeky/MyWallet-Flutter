part of 'page.dart';

class HomePage extends Page<HomeBloc> {
  HomePage({Key key}) : super(key: key);
  
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

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
      body: FutureBuilder<List<Wallet>>(
        initialData: const [],
        future: bloc.getWallets(),
        builder: (context, snapshot) => (snapshot.hasData) ? ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => WalletCard(snapshot.data[index])
          ) : const Center(child: CircularProgressIndicator(),)
      ),
    );
  }

}
