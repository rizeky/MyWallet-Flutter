

class Wallet {

  String name;
  int totalValue;
  Map details = {};

  Wallet(this.name, {this.details = const {}, this.totalValue = 0});
  
  factory Wallet.withName(String name) => Wallet(name);
  factory Wallet.withNameValue(String name, int totalValue) => 
    Wallet(name, totalValue: totalValue, details: {'First': totalValue});

  Wallet.fromJson(Map<String, dynamic> json): 
    name = json["name"] as String,
    totalValue = (json["totalValue"] as num).toInt(),
    details = json["details"] as Map;

  Map<String, dynamic> toJson() => {
    "name": name,
    "totalValue": totalValue,
    "details": details
  };

  @override
  String toString() => "$name($totalValue)";
  
}