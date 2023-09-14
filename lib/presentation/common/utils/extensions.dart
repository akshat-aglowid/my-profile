import 'package:flutter/material.dart';
import 'package:my_profile/presentation/common/utils/app_constants.dart';
import 'package:my_profile/presentation/localization/app_localizations.dart';
import 'package:my_profile/presentation/providers/login/login_provider.dart';
import 'package:my_profile/presentation/providers/user/user_provider.dart';
import 'package:provider/provider.dart';

extension GetString on BuildContext {
  String getString(String key) {
    final value = AppLocalizations.of(this)?.translate(key);
    return value != null ? value : "";
  }
}

extension ContextHelper on BuildContext {
  Future showRoundedBottomSheet(Widget bottomSheetWidget,
      {bool shouldAutoDismiss = false}) {
    return showModalBottomSheet(
      isDismissible: shouldAutoDismiss,
      backgroundColor: AppConstants.white,
      context: this,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      elevation: 10,
      builder: (context) {
        return bottomSheetWidget;
      },
    );
  }

  void clearProviderData() {
    Provider.of<LoginProvider>(this, listen: false).resetData();
    Provider.of<UserProvider>(this, listen: false).resetData();
  }
}
