import 'package:my_profile/data/common/preferences.dart';
import 'package:my_profile/domain/entities/error/common_error_entity.dart';
import 'package:my_profile/domain/entities/login/login_param.dart';
import 'package:my_profile/domain/entities/login/login_response_entity.dart';
import 'package:my_profile/domain/gateway/read_gateway.dart';
import 'package:my_profile/presentation/common/utils/app_constants.dart';

class LoginGateWay implements ReadGateWay<LoginResponseEntity, LoginParam> {
  @override
  Future<LoginResponseEntity> read(LoginParam loginParam) async {
    try {
      final Preferences prefs = Preferences();
      await new Future.delayed(const Duration(seconds: 1));
      if (loginParam.password == AppConstants.PASSWORD &&
          loginParam.userName == AppConstants.USER_NAME) {
        prefs.setRememberMe(loginParam.isRememberMe);
        return LoginResponseEntity(isLoggedIn: true);
      } else {
        return LoginResponseEntity(
            isLoggedIn: false,
            error: CommonError(message: "Invalid credentials", error: '400'));
      }
    } catch (error) {
      print(error);
      return LoginResponseEntity(
          isLoggedIn: false, error: CommonError.fromJson({}));
    }
  }
}
