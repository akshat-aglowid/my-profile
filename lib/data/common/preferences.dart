import 'package:my_profile/data/common/gateway_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// This method set for getting user name from shared preferences.
  Future<bool?> getRememberMe() async {
    SharedPreferences prefs = await _prefs;
    var isRememberMe = prefs.getBool(GateWayConstants.KEY_REMEMBER_ME);
    return isRememberMe;
  }

  /// This method store rememberMe in the shared Preference.
  ///
  /// To store [ rememberMe ] which we pass in the param.
  setRememberMe(bool isRememberMe) async {
    SharedPreferences prefs = await _prefs;
    prefs.setBool(GateWayConstants.KEY_REMEMBER_ME, isRememberMe);
  }

  /// Clear all shared preference data.
  clearData() async {
    SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }
}
