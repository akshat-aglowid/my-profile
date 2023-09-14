import 'package:flutter/material.dart';
import 'package:my_profile/domain/entities/user/user_entity.dart';
import 'package:my_profile/presentation/common/utils/app_constants.dart';

class UserProvider with ChangeNotifier {
  bool isEdit = false;

  UserEntity userEntity = UserEntity(
    userImage: "",
    userName: AppConstants.NAME,
    email: AppConstants.USER_NAME,
    skills: ["Kotlin", "Java", "Dart", "CI-CD", "Github"],
    workExperience: 5,
  );
  EditProfileField editProfileField = EditProfileField.NONE;

  onChangeUserImage(String image) {
    userEntity.userImage = image;
    notifyListeners();
  }

  setUserData(UserEntity userEntity) {
    this.userEntity = userEntity;
    notifyListeners();
  }

  onEditField(EditProfileField editProfileFieldName) {
    editProfileField = editProfileFieldName;
    notifyListeners();
  }

  resetData() {
    userEntity = UserEntity();
    editProfileField = EditProfileField.NONE;
  }

  discardScreen() {
    editProfileField = EditProfileField.NONE;
    isEdit = false;
  }
}
