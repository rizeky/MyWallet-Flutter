
part of 'bloc.dart';

class HomeBloc implements Bloc {

  final LocalService _localService = locator.get<LocalService>();
  final ValueNotifier<String> notifierTotalWalletCurr = ValueNotifier("Rp0");

  final BehaviorSubject<List<Wallet>> walletsController = BehaviorSubject();
  Stream<List<Wallet>> get walletsStream => walletsController.stream;

  @override
  void dispose() {
    walletsController.close();
  }

  @override
  void init() {
    getWallets();
  }
  
  final List<Wallet> _wallets = [];
  int _totalWallet = 0;

  void _updateWallets() {
    _wallets.clear();
    _wallets.addAll(_localService.wallets);
  }

  Future<void> getWallets() async {
    _wallets.addAll(_localService.wallets);
    for (final Wallet wallet in _wallets) {
      _totalWallet += wallet.totalValue;
    }
    notifierTotalWalletCurr.value = totalWalletCurr();
    walletsController.sink.add(_wallets);
  }

  Future<void> addWallet(String name, int value) async {
   await _localService.saveWallet(Wallet.withNameValue(name, value));
  _totalWallet += value;
  notifierTotalWalletCurr.value = totalWalletCurr();
   
   _updateWallets();
   walletsController.sink.add(_wallets);
  }

  String totalWalletCurr() {
    return convertCurrRP(_totalWallet);
  }
}


