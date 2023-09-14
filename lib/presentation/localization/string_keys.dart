import 'package:flutter/material.dart';

class StringKeys {
  static const ENGLISH = 0;
  static const HEBREW = 1;

  /// For supporting new languages add it here
  ///
  /// **Important** add it also to main.dart [MaterialApp.supportedLanguages]
  static const List<String> SUPPORTED_LANGUAGES = ['en', 'he'];

  static const String APP_TITLE = "appTitle";
  static const String LOGIN_BUTTON = "loginBtn";
  static const String USERNAME_HINT = "username";
  static const String PASSWORD_HINT = "password";
  static const String EMPTY_USERNAME_ERROR_MESSAGE =
      "emptyUserNameErrorMessage";
  static const String EMPTY_PASSWORD_ERROR_MESSAGE =
      "emptyPasswordErrorMessage";
  static const String REMEMBERED_ME = "rememberedMe";
  static const String HOME_TITLE = "homeTitle";
  static const String EMAIL_LABEL = "emailLabel";
  static const String SKILLS_LABEL = "skillsLabel";
  static const String WORK_EXPERIENCE_LABEL = "workExperienceLabel";
  static const String YEARS_LABEL = "yearsLabel";
  static const String EDIT_PROFILE_TITLE = "editProfileTitle";
  static const String SAVE_BUTTON = "saveBtn";
  static const String EMPTY_EMAIL_ERROR_MESSAGE = "emptyEmailErrorMessage";
  static const String EMPTY_WORK_EXPERIENCE_ERROR_MESSAGE =
      "emptyWorkExperienceErrorMessage";
  static const String ALERT = "alert";
  static const String ALERT_MESSAGE = "alertMessage";
  static const String CANCEL = "cancel";
  static const String DISCARD = "discard";
}
