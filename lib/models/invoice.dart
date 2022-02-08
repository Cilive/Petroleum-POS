class Invoice {
  int? id;
  int? invoiceNo;
  String? date;
  double? qty;
  double? grossAmt;
  String? paymentType;
  String? type;
  double? totalAmt;
  double? creditAmount;
  String? accountNumber;
  int? vatPercenatge;
  double? vatAmount;
  double? paidAmt;
  double? balanceAmt;
  String? createdAt;
  String? updatedAt;
  int? expType;
  int? refNo;
  double? fuelvatPercentage;
  int? session;
  int? branches;
  String? contact;
  int? emp;
  int? fuel;
  int? company;
  int? vat;
  int? bank;
  int? cash;
  String? qrCode;

  Invoice(
      {this.id,
      this.invoiceNo,
      this.date,
      this.qty,
      this.grossAmt,
      this.paymentType,
      this.type,
      this.totalAmt,
      this.creditAmount,
      this.accountNumber,
      this.vatPercenatge,
      this.vatAmount,
      this.paidAmt,
      this.balanceAmt,
      this.createdAt,
      this.updatedAt,
      this.expType,
      this.refNo,
      this.fuelvatPercentage,
      this.session,
      this.branches,
      this.contact,
      this.emp,
      this.fuel,
      this.company,
      this.vat,
      this.bank,
      this.cash,
      this.qrCode});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNo = json['invoice_no'];
    date = json['date'];
    qty = json['qty'];
    grossAmt = json['gross_amt'];
    paymentType = json['payment_type'];
    type = json['type'];
    totalAmt = json['total_amt'];
    creditAmount = json['credit_amount'];
    accountNumber = json['account_number'];
    vatPercenatge = json['vat_percenatge'];
    vatAmount = json['vat_amount'];
    paidAmt = json['paid_amt'];
    balanceAmt = json['balance_amt'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expType = json['exp_type'];
    refNo = json['ref_no'];
    fuelvatPercentage = json['fuelvat_percentage'];
    session = json['session'];
    branches = json['branches'];
    contact = json['contact'];
    emp = json['emp'];
    fuel = json['fuel'];
    company = json['company'];
    vat = json['vat'];
    bank = json['bank'];
    cash = json['cash'];
    qrCode = json['base_64_encoded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_no'] = this.invoiceNo;
    data['date'] = this.date;
    data['qty'] = this.qty;
    data['gross_amt'] = this.grossAmt;
    data['payment_type'] = this.paymentType;
    data['type'] = this.type;
    data['total_amt'] = this.totalAmt;
    data['credit_amount'] = this.creditAmount;
    data['account_number'] = this.accountNumber;
    data['vat_percenatge'] = this.vatPercenatge;
    data['vat_amount'] = this.vatAmount;
    data['paid_amt'] = this.paidAmt;
    data['balance_amt'] = this.balanceAmt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['exp_type'] = this.expType;
    data['ref_no'] = this.refNo;
    data['fuelvat_percentage'] = this.fuelvatPercentage;
    data['session'] = this.session;
    data['branches'] = this.branches;
    data['contact'] = this.contact;
    data['emp'] = this.emp;
    data['fuel'] = this.fuel;
    data['company'] = this.company;
    data['vat'] = this.vat;
    data['bank'] = this.bank;
    data['cash'] = this.cash;
    data['base_64_encoded'] = this.qrCode;
    return data;
  }
}
