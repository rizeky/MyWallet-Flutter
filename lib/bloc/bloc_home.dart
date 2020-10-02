
part of 'bloc.dart';

class HomeBloc implements Bloc {

  final LocalService _localService = locator.get<LocalService>();

  @override
  void dispose() {}

  @override
  void init() {}

  final NumberFormat _numRpCurr = NumberFormat.simpleCurrency(name: "Rp", decimalDigits: 0);
  
  final List<Wallet> _wallets = [];
  // List<Wallet> get wallets => _wallets;

  Future<List<Wallet>> getWallets() async {
    await _localService.loadWallets().then((value) => _wallets.addAll(value));
    return _wallets;
  }
}


