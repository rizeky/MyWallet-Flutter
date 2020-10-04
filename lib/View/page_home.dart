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
      body:StreamBuilder<List<Wallet>>(
        stream: _bloc.walletsStream,
        builder: (context, snapshot) => (snapshot.hasData) ? Padding(
          padding: const EdgeInsets.all(24),
          child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => WalletCard(snapshot.data[index])
            ),
        ) : const Center(child: CircularProgressIndicator(),),
      ),
      floatingActionButton: Builder(
        builder: (scaffContext) => FloatingActionButton(
          elevation: 0,
          highlightElevation: 0,
          onPressed: () => showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
            isScrollControlled: true,
            context: scaffContext,
            builder: (context) {

              final TextEditingController walletNameCon = TextEditingController();
              final TextEditingController walletValueCon = TextEditingController();

              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Material(
                  color: blackColor,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Input Wallet', style: whiteSubtitle),
                        const SizedBox(height: 12,),
                        XTextField(
                          labelText: 'Wallet Name',
                          labelStyle: whiteSubtitle,
                          controller: walletNameCon,
                        ),
                        const SizedBox(height: 12,),
                        XTextField(
                          labelText: 'Wallet Value',
                          labelStyle: whiteSubtitle,
                          controller: walletValueCon,
                        ),
                        const SizedBox(height: 12,),
                        ButtonBar(
                          children: [
                            FlatButton(
                              minWidth: 50,
                              onPressed: () => Navigator.pop(context),
                              child: Text('CANCEL', style: whiteContentRegular,),
                            ),
                            FlatButton(
                              minWidth: 50,
                              color: mainColor,
                              onPressed: () {
                                _bloc.addWallet(walletNameCon.text, int.parse(walletValueCon.text));
                                Navigator.pop(context);
                              },
                              child: const Text('CREATE'),
                            ),
                          ],
                        )
                      ],
                    )
                  )
                ),
              );
            }
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

}
