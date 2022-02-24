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
}
