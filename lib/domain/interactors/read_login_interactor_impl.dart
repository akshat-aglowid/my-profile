import 'package:my_profile/domain/entities/login/login_param.dart';
import 'package:my_profile/domain/entities/login/login_response_entity.dart';
import 'package:my_profile/domain/gateway/read_gateway.dart';
import 'package:my_profile/domain/interactors/read_login_interactor.dart';

class ReadLoginInteractorImpl implements ReadLoginInteractor {
  final ReadGateWay<LoginResponseEntity, LoginParam> gateWay;

  ReadLoginInteractorImpl({required this.gateWay});

  @override
  Future<LoginResponseEntity> doLogin(LoginParam loginParam) {
    return gateWay.read(loginParam);
  }
}
