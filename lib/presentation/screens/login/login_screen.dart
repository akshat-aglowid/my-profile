import 'package:flutter/material.dart';
import 'package:my_profile/data/common/preferences.dart';
import 'package:my_profile/domain/entities/login/login_param.dart';
import 'package:my_profile/presentation/common/utils/app_constants.dart';
import 'package:my_profile/presentation/common/utils/extensions.dart';
import 'package:my_profile/presentation/common/widgets/custom_orange_button.dart';
import 'package:my_profile/presentation/common/widgets/custom_textfield.dart';
import 'package:my_profile/presentation/common/widgets/simple_alert_dialog.dart';
import 'package:my_profile/presentation/localization/string_keys.dart';
import 'package:my_profile/presentation/providers/loader/loader_provider.dart';
import 'package:my_profile/presentation/providers/login/login_provider.dart';
import 'package:my_profile/presentation/screens/home/home_screen.dart';
import 'package:my_profile/presentation/screens/login/widgets/remember_me_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginProvider? loginProvider;
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Preferences preferences = Preferences();

  @override
  void initState() {
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    checkRememberedMe();
    super.initState();
  }

  checkRememberedMe() async {
    var isRememberedMe = await preferences.getRememberMe();
    if (isRememberedMe != null && isRememberedMe) {
      _userNameController.text = AppConstants.USER_NAME;
      _passwordController.text = AppConstants.PASSWORD;
      loginProvider?.onChangeRemember(isRememberedMe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 72),
                    FlutterLogo(size: 96),
                    SizedBox(height: 88),
                    _getEmailTextFieldContainer(),
                    SizedBox(height: 16),
                    _getPasswordTextFieldContainer(),
                    SizedBox(height: 8),
                    RememberMeWidget(),
                    SizedBox(height: 32),
                    CustomOrangeButtonWidget(
                        title: context.getString(StringKeys.LOGIN_BUTTON),
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Provider.of<LoaderProvider>(context, listen: false)
                                .showHideLoader(true);
                            _doLogin();
                          }
                        },
                        horizontalSpacing: 32),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Consumer<LoaderProvider>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.isShowLoader,
                  child: Container(
                    alignment: Alignment.center,
                    color: Color(0xFF00000f).withOpacity(0.5),
                    child: CircularProgressIndicator(color: Color(0xFFFA7F25)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _getEmailTextFieldContainer() {
    return CustomTextFieldWidget(
        controller: _userNameController,
        hintText: context.getString(StringKeys.USERNAME_HINT),
        validator: (value) {
          if (value!.isEmpty) {
            return context.getString(StringKeys.EMPTY_USERNAME_ERROR_MESSAGE);
          }
          return null;
        });
  }

  _getPasswordTextFieldContainer() {
    return CustomTextFieldWidget(
        controller: _passwordController,
        hintText: context.getString(StringKeys.PASSWORD_HINT),
        isPasswordField: true,
        isShowSuffixIcon: true,
        validator: (value) {
          if (value!.isEmpty) {
            return context.getString(StringKeys.EMPTY_PASSWORD_ERROR_MESSAGE);
          }
          return null;
        });
  }

  _doLogin() async {
    final response = await loginProvider?.doLogin(LoginParam(
      userName: _userNameController.text,
      password: _passwordController.text,
      isRememberMe: loginProvider?.isRememberedMe ?? false,
    ));
    Provider.of<LoaderProvider>(context, listen: false).showHideLoader(false);
    if (response != null && response.isLoggedIn) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false);
    } else {
      if (response != null && response.error != null)
        SimpleAlertDialog(
          title: context.getString(StringKeys.APP_TITLE),
          context: context,
          message: response.error!.message,
          onPressedOk: () {},
        ).show();
    }
  }
}
