
part of 'bloc.dart';

class HomeBloc implements Bloc {
  HomeBloc();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

  var _values = 0;
  final Map<String, Wallet> _wallets = {};
  final NumberFormat _numRpCurr = NumberFormat.simpleCurrency(name: "Rp", decimalDigits: 0);

  void updateValues() {
    int temp = 0;
    for (final Wallet wallet in _wallets.values) {
      temp += wallet.totalValue;
    }
    _values = temp;
  }

  void updateValueWallet(String walletName) {
    if (_wallets.containsKey(walletName)){
      if (_wallets[walletName].details.isNotEmpty) {
        int temp = 0;
        for (final int value in _wallets[walletName].details.values) {
          temp += value;
        }
        _wallets[walletName].totalValue = temp;
      }
      else {
        _wallets[walletName].totalValue = 0;
      }
    }
  }

  void addDetailWallet(String walletName, String detailName, int detailValue) {
    if (_wallets.containsKey(walletName)){
      _wallets[walletName].details[detailName] = detailValue;
      updateValueWallet(walletName);
      updateValues(); 
    }
  }

  void addWalletWithName(String walletName) {
    if (!_wallets.containsKey(walletName)) {
      _wallets[walletName] = Wallet.withName(walletName);
      updateValueWallet(walletName);
      updateValues();  
    }
  }

  void deleteWallet(String walletName) {
    if (_wallets.containsKey(walletName)) {
      _wallets.remove(walletName);
      updateValueWallet(walletName);
      updateValues();
    }
  }

  String getValueWallet(String name) {
    if (_wallets.containsKey(name)) {
      return _numRpCurr.format(_wallets[name].totalValue);
    } else {
      return "-1";
    }
  }

  String getNameWallet(int index) {
    if (_wallets.isNotEmpty) {
      final List<String> ls = _wallets.keys.toList();
      return ls[index];
    } 
    else {
      return "null";
    }
  }

  int getLengthWallet() {
    return _wallets.length;
  }

  String getValues() {
    return _numRpCurr.format(_values);
  }

  String getValueDetailWallet(String walletName, String detailName) {
    if (_wallets.containsKey(walletName)) {
      if (_wallets[walletName].details.containsKey(detailName)) {
        return _numRpCurr.format(_wallets[walletName].details[detailName]);
      } else {
        return "-1";
      }
    } else {
      return "-1";
    }
  }

  void incrementValueDetailWallet(String walletName, String detailName, int value) {
    if (_wallets.containsKey(walletName) && _wallets[walletName].details.containsKey(detailName)) {
      _wallets[walletName].details[detailName] += value;
      updateValueWallet(walletName);
      updateValues();
    }
  }
  void decrementValueDetailWallet(String walletName, String detailName, int value) {
    if (_wallets.containsKey(walletName) && _wallets[walletName].details.containsKey(detailName)) {
      _wallets[walletName].details[detailName] -= value;
      updateValueWallet(walletName);
      updateValues();
    }
  }

  void setValueDetailWallet(String walletName, String detailName, int value) {
    if (_wallets.containsKey(walletName) && _wallets[walletName].details.containsKey(detailName)) {
      _wallets[walletName].details[detailName] = value;
      updateValueWallet(walletName);
      updateValues();
    }
  }

  void deleteDetailWallet(String walletName, String detailName) {
    if (_wallets.containsKey(walletName) && _wallets[walletName].details.containsKey(detailName)) {
      _wallets[walletName].details.remove(detailName);
      updateValueWallet(walletName);
      updateValues();
    }
  }

  String getNameDetailWallet(String walletName, int index) {
    if (_wallets.containsKey(walletName)) {
      final List<String> ls = _wallets[walletName].details.keys.toList();
      return ls[index];
    }
    else {
      return "null";
    }
  }

  int getLengthDetailWallet(String walletName) {
    if (_wallets.containsKey(walletName)) {
      return _wallets[walletName].details.length;
    } else {
      return 0;
    }
  }
}


