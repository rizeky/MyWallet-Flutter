part of 'service.dart';

class LocalService {
  Future<void> saveWallets(List<Wallet> wallets) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodeWallets = json.encode(wallets);
    prefs.setString("encodeWallets", encodeWallets);
  }

  Future<List<Wallet>> loadWallets() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodeWallets = prefs.getString("encodeWallets") ?? "{}";
    
    final Map<String, String> decodeWallets = json.decode(encodeWallets) as Map<String, String>;
    final List<Wallet> wallets = [];

    for (final String walletName in decodeWallets.keys) {
      wallets.add(Wallet.fromJson(decodeWallets[walletName] as Map<String, dynamic>));
    }
    return wallets;
  }

}