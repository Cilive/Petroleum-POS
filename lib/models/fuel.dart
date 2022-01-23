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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fuel_vat'] = this.fuelVat;
    data['rate'] = this.rate;
    data['payable_amt'] = this.payableAmt;
    data['current_stock'] = this.currentStock;
    data['company'] = this.company;
    return data;
  }
}