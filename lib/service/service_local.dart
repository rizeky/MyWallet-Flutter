part of 'service.dart';

class LocalService {

  final List<Wallet> _wallets = [];
  List<Wallet> get wallets => _wallets;

  Box box;

  Future<void> init() async {
    
    await Hive.initFlutter();
    box = await Hive.openBox('walletsBox');
    
    await loadWallets();
  }

  void saveWallet(Wallet wallet) {
    _wallets.add(wallet);
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

      await SharedPreferences.getInstance()
        .then((prefs) {
          final String encodeWallets = prefs.getString("encodeWallets") ?? "{}";
          final Map<String, String> decodeWallets = json.decode(encodeWallets) as Map<String, String>;

          for (final String walletName in decodeWallets.keys) {
            _wallets.add(Wallet.fromJson(decodeWallets[walletName] as Map<String, dynamic>));
          }
        }).timeout(const Duration(seconds: 10));
      
      return _wallets;

    } catch (e) {
      return _wallets;
    }
  }
}