class Company {
  String? enName;
  String? arName;
  String? vatNo;
  String? crNo;
  String? lanNo;
  String? phone;

  Company(
      {this.enName,
      this.arName,
      this.vatNo,
      this.crNo,
      this.lanNo,
      this.phone});

  Company.fromJson(Map<String, dynamic> json) {
    enName = json['en_name'];
    arName = json['ar_name'];
    vatNo = json['vat_no'];
    crNo = json['cr_no'];
    lanNo = json['lan_no'];
    phone = json['phone'];
  }
}