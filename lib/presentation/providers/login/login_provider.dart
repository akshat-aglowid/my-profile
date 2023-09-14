import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:my_profile/domain/entities/login/login_param.dart';
import 'package:my_profile/domain/entities/login/login_response_entity.dart';
import 'package:my_profile/domain/interactors/read_login_interactor.dart';

class LoginProvider with ChangeNotifier {
  bool isRememberedMe = false;

  Future<LoginResponseEntity> doLogin(LoginParam param) async {
    return await Injector().get<ReadLoginInteractor>().doLogin(param);
  }

  onChangeRemember(bool isCheck) {
    isRememberedMe = isCheck;
    notifyListeners();
  }

  resetData() {
    isRememberedMe = false;
  }
}
