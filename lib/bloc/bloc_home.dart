
part of 'bloc.dart';

class HomeBloc implements Bloc {

  final LocalService _localService = locator.get<LocalService>();
  final ValueNotifier<String> notifierTotalWalletCurr = ValueNotifier("Rp0");

  @override
  void dispose() {}

  @override
  void init() {}

  final NumberFormat _numRpCurr = NumberFormat.simpleCurrency(name: "Rp", decimalDigits: 0);
  
  final List<Wallet> _wallets = [];
  int _totalWallet = 0;
  // List<Wallet> get wallets => _wallets;

  Future<List<Wallet>> getWallets() async {
    await _localService.loadWallets().then((value) => _wallets.addAll(value));
    for (final Wallet wallet in _wallets) {
      _totalWallet += wallet.totalValue;
    }
    notifierTotalWalletCurr.value = totalWalletCurr();
    return _wallets;
  }

  String totalWalletCurr() {
    return _numRpCurr.format(_totalWallet);
  }
}


