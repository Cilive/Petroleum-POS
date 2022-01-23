
class Dispenser {
  int? id;
  String? name;
  int? branches;
  int? company;
  int? dispencerCount;

  Dispenser(
      {this.id, this.name, this.branches, this.company, this.dispencerCount});

  Dispenser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    branches = json['branches'];
    company = json['company'];
    dispencerCount = json['dispencer_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['branches'] = this.branches;
    data['company'] = this.company;
    data['dispencer_count'] = this.dispencerCount;
    return data;
  }
}