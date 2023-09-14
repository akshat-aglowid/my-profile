enum EditProfileField { NAME, EMAIL, SKILLS, WORK_EXPERIENCE, NONE }

class UserEntity {
  String? userImage;
  String? userName;
  String? email;
  List<String>? skills;
  int? workExperience;

  UserEntity({
    this.userImage,
    this.userName,
    this.email,
    this.skills,
    this.workExperience,
  });
}
