class Wallet {
  Wallet();
  Wallet.withName(this.name);
  Wallet.withNameValue(this.name, this.value);
  Wallet.fromJson(Map<String, dynamic> json): 
    this.name = json["name"],
    this.value = json["value"],
    this.details = json["details"];

  String name = "";
  int value = 0;

  Map details = <String, int>{};

  Map<String, dynamic> toJson() => {
    "name": this.name,
    "value": this.value,
    "details": this.details
  };

  String toString() => "${this.name}: ${this.value}";
  
}