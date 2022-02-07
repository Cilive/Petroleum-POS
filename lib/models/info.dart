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
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en_name'] = this.enName;
    data['ar_name'] = this.arName;
    data['vat_no'] = this.vatNo;
    data['cr_no'] = this.crNo;
    data['lan_no'] = this.lanNo;
    data['phone'] = this.phone;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}
