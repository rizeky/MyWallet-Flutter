part of 'service.dart';

class LocalService {

  final List<Wallet> _wallets = [];
  List<Wallet> get wallets => _wallets;
  
  Future<void> saveWallets() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodeWallets = json.encode(wallets);
    await prefs.setString("encodeWallets", encodeWallets);
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