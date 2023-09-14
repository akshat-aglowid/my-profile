class LoginParam {
  LoginParam({
    required this.userName,
    required this.password,
    this.isRememberMe = false,
  });

  final String userName;
  final String password;
  final bool isRememberMe;
}
