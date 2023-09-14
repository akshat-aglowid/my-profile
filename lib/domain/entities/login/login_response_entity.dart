import 'package:my_profile/domain/entities/error/common_error_entity.dart';

class LoginResponseEntity {
  CommonError? error;
  bool isLoggedIn;

  LoginResponseEntity({this.isLoggedIn = false,  this.error});
}
