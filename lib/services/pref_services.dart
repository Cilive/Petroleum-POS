import 'package:shared_preferences/shared_preferences.dart';
import 'package:skysoft/models/pref_data.dart';

class PreferenceService {
  setPrefData(PrefData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access', data.access!);
    prefs.setString('refresh', data.refresh!);
    prefs.setString('tenant_name', data.empTenantName!.username!);
  }

  setAccessToken(String? access) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access', access!);
    await getPrefData();
  }

  Future<PrefData> getPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _access = prefs.getString('access');
    var _refresh = prefs.getString('refresh');
    var _tenant = prefs.getString('tenant_name');
    PrefData basicData = PrefData(access: _access, refresh: _refresh, empTenantName: EmpTenantName(username: _tenant));
    return basicData;
  }

  deletePrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
