import 'package:my_profile/domain/entities/login/login_param.dart';
import 'package:my_profile/domain/entities/login/login_response_entity.dart';

abstract class ReadLoginInteractor {
  Future<LoginResponseEntity> doLogin(LoginParam loginParam);
}
