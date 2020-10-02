part of 'page.dart';

class HomePage extends Page<HomeBloc> {
  HomePage({Key key}) : super(key: key);
  
  @override
  void dispose() {}

  @override
  void init() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XTopBar(
        title: ValueListenableBuilder<String>(
          valueListenable: _bloc.notifierTotalWalletCurr, 
          builder: (context, value, child) => Text(value)),
        leading: const Icon(Icons.account_balance_wallet),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/inputwallet'),
          )
        ],  
      ),
      body: FutureBuilder<List<Wallet>>(
        future: _bloc.getWallets(),
        builder: (context, snapshot) => (snapshot.hasData) ? 
          (snapshot.data.isNotEmpty) ? ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => WalletCard(snapshot.data[index])
          ) : const Center(child: Text('No wallets found')) 
          : const Center(child: CircularProgressIndicator(),)
      ),
    );
  }

}
