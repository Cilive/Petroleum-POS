import 'package:skysoft/models/company.dart';

class Info {
  String? enName;
  String? arName;
  String? vatNo;
  String? crNo;
  String? lanNo;
  String? phone;
  Company? company;

  Info(
      {this.enName,
      this.arName,
      this.vatNo,
      this.crNo,
      this.lanNo,
      this.phone,
      this.company});

  Info.fromJson(Map<String, dynamic> json) {
    enName = json['en_name'];
    arName = json['ar_name'];
    vatNo = json['vat_no'];
    crNo = json['cr_no'];
    lanNo = json['lan_no'];
    phone = json['phone'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }
}
