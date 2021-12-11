import 'package:shared_preferences/shared_preferences.dart';
import 'package:skysoft/models/pref_data.dart';

class PreferenceService {
  setPrefData(PrefData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access', data.access!);
    prefs.setString('refresh', data.refresh!);
    prefs.setString('id', data.id!);
  }

  Future<PrefData> getPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _access = prefs.getString('access');
    var _refresh = prefs.getString('refresh');
    var _id = prefs.getString('id');

    PrefData basicData = PrefData(access: _access, refresh: _refresh, id: _id);

    return basicData;
  }

  deletePrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
