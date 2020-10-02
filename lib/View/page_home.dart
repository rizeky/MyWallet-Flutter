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
      floatingActionButton: Builder(
        builder: (scaffContext) => FloatingActionButton(
          elevation: 0,
          highlightElevation: 0,
          onPressed: () => showModalBottomSheet(
            context: scaffContext,
            builder: (context) {

              final TextEditingController walletNameCon = TextEditingController();

              return Material(
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Input Wallet Name', style: blackSubtitle),
                      const SizedBox(height: 12,),
                      XTextField(
                        labelText: 'Wallet Name',
                        labelStyle: blackSubtitle,
                        controller: walletNameCon,
                      ),
                      const SizedBox(height: 12,),
                      ButtonBar(
                        children: [
                          FlatButton(
                            minWidth: 50,
                            onPressed: () {},
                            child: Text('CANCEL', style: blackContentRegular,),
                          ),
                          FlatButton(
                            minWidth: 50,
                            color: mainColor,
                            onPressed: () {},
                            child: const Text('CREATE'),
                          ),
                        ],
                      )
                    ],
                  )
                )
              );
            }
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

}
