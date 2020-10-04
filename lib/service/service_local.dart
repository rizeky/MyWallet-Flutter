part of 'service.dart';

class LocalService {

  final List<Wallet> _wallets = [];
  List<Wallet> get wallets => _wallets;

  Box box;

  Future<void> init() async {
    
    await Hive.initFlutter();
    box = await Hive.openBox('walletsBox');
    // box.deleteFromDisk();
    
    await loadWallets();
  }

  Future<void> saveWallet(Wallet wallet) async {
    _wallets.add(wallet);
    await box.put(wallet.name, wallet.toJson());
  }

  Future<void> saveWallets() async {
    final Map<String, Map<String, dynamic>> data = {};
    for (final Wallet wallet in _wallets) {
      data[wallet.name] = wallet.toJson();
    }
    await box.putAll(data);
  }

  Future<List<Wallet>> loadWallets() async {
    try {

      for (int i = 0; i < box.length; i++) {
        final Map data = await box.getAt(i) as Map;
        _wallets.add(Wallet.fromJson(Map<String, dynamic>.from(data)));
      }
      print(_wallets);
      return _wallets;

    } catch (e) {
      print(e);
      return _wallets;
    }
  }
}