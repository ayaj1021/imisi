import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  saveUserAccountType(String accountType) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString("account_type", accountType);
    // print(accountType);
  }

  // saveUserToken(String value) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString("token", value);
  //   // print(key);
  // }

  getUserToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? type = pref.getString("token");
    return type;
    //  print(key);
  }

  getUserAccountType() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? type = sf.getString("account_type");
    return type;
  }

  saveUserToken(String token) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString("token", token);
  }

  // saveUserRefreshToken(String refreshToken) async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   sf.setString("refresh_token", refreshToken);
  // }

  // saveResetPasswordToken(String resetPasswordToken) async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   sf.setString("reset_password_token", resetPasswordToken);
  // }

  // saveUserId(String userId) async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   sf.setString("user_id", userId);
  // }

  // saveProviderId(String provider_id) async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   sf.setString("provider_id", provider_id);
  // }
}
