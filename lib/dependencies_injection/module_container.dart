import 'package:my_profile/data/gateway/login_gate_way.dart';
import 'package:my_profile/domain/interactors/read_login_interactor.dart';
import 'package:my_profile/domain/interactors/read_login_interactor_impl.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class ModuleContainer {
  Injector initialise(Injector injector) {
    injector.map<ReadLoginInteractor>(
        (i) => ReadLoginInteractorImpl(gateWay: LoginGateWay()),
        isSingleton: false);
    return injector;
  }
}
