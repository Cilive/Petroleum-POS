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
}

class EmpCompanyUserId {
  int? user;

  EmpCompanyUserId({this.user});

  EmpCompanyUserId.fromJson(Map<String, dynamic> json) {
    user = json['user'];
  }
}

class EmpTenantName {
  String? username;

  EmpTenantName({this.username});

  EmpTenantName.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }
}