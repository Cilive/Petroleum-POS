class Fuel {
  int? id;
  String? name;
  int? fuelVat;
  double? rate;
  double? payableAmt;
  double? currentStock;
  int? company;

  Fuel(
      {this.id,
      this.name,
      this.fuelVat,
      this.rate,
      this.payableAmt,
      this.currentStock,
      this.company});

  Fuel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fuelVat = json['fuel_vat'];
    rate = json['rate'];
    payableAmt = json['payable_amt'];
    currentStock = json['current_stock'];
    company = json['company'];
  }
}