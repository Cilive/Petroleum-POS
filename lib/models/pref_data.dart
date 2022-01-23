class PrefData {
  String? refresh;
  String? access;
  String? username;
  bool? isAdmin;
  bool? isCompany;
  bool? isEmployee;
  bool? isSuperuser;
  bool? isBranchUser;
  String? companyId;
  EmpCompanyUserId? empCompanyUserId;
  EmpTenantName? empTenantName;

  PrefData(
      {this.refresh,
      this.access,
      this.username,
      this.isAdmin,
      this.isCompany,
      this.isEmployee,
      this.isSuperuser,
      this.isBranchUser,
      this.companyId,
      this.empCompanyUserId,
      this.empTenantName});

  PrefData.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    username = json['username'];
    isAdmin = json['is_admin'];
    isCompany = json['is_company'];
    isEmployee = json['is_employee'];
    isSuperuser = json['is_superuser'];
    isBranchUser = json['is_branch_user'];
    companyId = json['company_id'];
    empCompanyUserId = json['emp_company_user_id'] != null
        ? EmpCompanyUserId.fromJson(json['emp_company_user_id'])
        : null;
    empTenantName = json['emp_tenant_name'] != null
        ? EmpTenantName.fromJson(json['emp_tenant_name'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    data['username'] = this.username;
    data['is_admin'] = this.isAdmin;
    data['is_company'] = this.isCompany;
    data['is_employee'] = this.isEmployee;
    data['is_superuser'] = this.isSuperuser;
    data['is_branch_user'] = this.isBranchUser;
    data['company_id'] = this.companyId;
    if (this.empCompanyUserId != null) {
      data['emp_company_user_id'] = this.empCompanyUserId!.toJson();
    }
    if (this.empTenantName != null) {
      data['emp_tenant_name'] = this.empTenantName!.toJson();
    }
    return data;
  }
}

class EmpCompanyUserId {
  int? user;

  EmpCompanyUserId({this.user});

  EmpCompanyUserId.fromJson(Map<String, dynamic> json) {
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = this.user;
    return data;
  }
}

class EmpTenantName {
  String? username;

  EmpTenantName({this.username});

  EmpTenantName.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    return data;
  }
}