class PrefData {
  String? access;
  String? refresh;
  String? id;

  PrefData({this.access, this.id, this.refresh});

  PrefData.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
    id = json['employee_id'].toString();
  }
}
