import 'package:mywallet/Model/Model.dart' show Wallet;
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:intl/intl.dart' show NumberFormat;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;
import 'dart:convert' show json;

class Controller with ChangeNotifier {
  Controller() {
    this.loadWallets();
  }

  var _values = 0;
  var _wallets = <String, Wallet>{};
  var _numRpCurr = new NumberFormat.simpleCurrency(name: "Rp", decimalDigits: 0);

  void updateValues() {
    int temp = 0;
    for (Wallet wallet in this._wallets.values) {
      temp += wallet.value;
    }
    this._values = temp;
  }

  void saveWallets() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodeWallets = json.encode(this._wallets);
    prefs.setString("encodeWallets", encodeWallets);
    // print("save wallets success");
  }

  Future<void> loadWallets() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodeWallets = prefs.getString("encodeWallets") ?? "{}";
    
    Map wallets = json.decode(encodeWallets);
    for (String walletName in wallets.keys) {
      this._wallets[walletName] = Wallet.fromJson(wallets[walletName]);
    }
    this.notifyListeners();
    // print("load wallets success");
  }

  void updateValueWallet(String walletName) {
    if (this._wallets.containsKey(walletName)){
      if (this._wallets[walletName].details.length > 0) {
        int temp = 0;
        for (int value in this._wallets[walletName].details.values)
          temp += value;
        this._wallets[walletName].value = temp;
      }
      else this._wallets[walletName].value = 0;
      this.notifyListeners();
    }
    // else print("wallet $walletName gak ada");
  }

  void addDetailWallet(String walletName, String detailName, int detailValue) {
    if (this._wallets.containsKey(walletName)){
      this._wallets[walletName].details[detailName] = detailValue;
      // print("add detail success");
      this.updateValueWallet(walletName);
      this.updateValues();  
      this.saveWallets();
      this.notifyListeners();
    }
    // else print("wallet name does not exist");
  }

  void addWalletWithName(String walletName) {
    if (!this._wallets.containsKey(walletName)) {
      this._wallets[walletName] = new Wallet.withName(walletName);
      // print("add wallet success");
      this.updateValueWallet(walletName);
      this.updateValues();  
      this.saveWallets();
      this.notifyListeners();
    }
    // else print("wallet name does exist");
  }

  void deleteWallet(String walletName) {
    if (this._wallets.containsKey(walletName)) {
      this._wallets.remove(walletName);
      this.updateValueWallet(walletName);
      this.updateValues();  
      this.saveWallets();
      this.notifyListeners();
    }
  }

  String getValueWallet(String name) {
    if (this._wallets.containsKey(name)) return _numRpCurr.format(this._wallets[name].value);
    else return "-1";
  }

  String getNameWallet(int index) {
    if (this._wallets.length > 0) {
      List<String> ls = this._wallets.keys.toList();
      return ls[index];
    } 
    else return "null";
  }

  int getLengthWallet() {
    return this._wallets.length;
  }

  String getValues() {
    return this._numRpCurr.format(this._values);
  }

  String getValueDetailWallet(String walletName, String detailName) {
    if (this._wallets.containsKey(walletName))
      if (this._wallets[walletName].details.containsKey(detailName)) 
        return _numRpCurr.format(this._wallets[walletName].details[detailName]);
      else return "-1";
    else return "-1";
  }

  void incrementValueDetailWallet(String walletName, String detailName, int value) {
    if (this._wallets.containsKey(walletName))
      if (this._wallets[walletName].details.containsKey(detailName)) {   
        this._wallets[walletName].details[detailName] += value;
        this.updateValueWallet(walletName);
        this.updateValues();
        this.saveWallets();
        this.notifyListeners();
      }
  }
  void decrementValueDetailWallet(String walletName, String detailName, int value) {
    if (this._wallets.containsKey(walletName))
      if (this._wallets[walletName].details.containsKey(detailName)) {
        this._wallets[walletName].details[detailName] -= value;
        this.updateValueWallet(walletName);
        this.updateValues();
        this.saveWallets();
        this.notifyListeners();
      }
  }

  void setValueDetailWallet(String walletName, String detailName, int value) {
    if (this._wallets.containsKey(walletName))
      if (this._wallets[walletName].details.containsKey(detailName)) {
        this._wallets[walletName].details[detailName] = value;
        this.updateValueWallet(walletName);
        this.updateValues();
        this.saveWallets();
        this.notifyListeners();
      }
  }

  void deleteDetailWallet(String walletName, String detailName) {
    if (this._wallets.containsKey(walletName)) 
      if (this._wallets[walletName].details.containsKey(detailName)) {
        this._wallets[walletName].details.remove(detailName);
        this.updateValueWallet(walletName);
        this.updateValues();
        this.saveWallets();
        this.notifyListeners();
      }
  }

  String getNameDetailWallet(String walletName, int index) {
    if (this._wallets.containsKey(walletName)) {
      List<String> ls = this._wallets[walletName].details.keys.toList();
      return ls[index];
    }
    else return "null";
  }

  int getLengthDetailWallet(String walletName) {
    if (this._wallets.containsKey(walletName)) 
      return this._wallets[walletName].details.length;
    else return 0;
  }
}


