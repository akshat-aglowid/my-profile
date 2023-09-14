import 'package:flutter/material.dart';

class LoaderProvider with ChangeNotifier {
  bool isShowLoader = false;

  showHideLoader(bool isShow) {
    isShowLoader = isShow;
    notifyListeners();
  }
}
