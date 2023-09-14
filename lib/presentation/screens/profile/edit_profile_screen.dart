import 'package:flutter/material.dart';
import 'package:my_profile/domain/entities/user/user_entity.dart';
import 'package:my_profile/presentation/common/utils/extensions.dart';
import 'package:my_profile/presentation/common/widgets/custom_orange_button.dart';
import 'package:my_profile/presentation/common/widgets/custom_textfield.dart';
import 'package:my_profile/presentation/localization/string_keys.dart';
import 'package:my_profile/presentation/providers/user/user_provider.dart';
import 'package:my_profile/presentation/screens/home/widgets/name_widget.dart';
import 'package:my_profile/presentation/screens/home/widgets/skills_widget.dart';
import 'package:my_profile/presentation/screens/home/widgets/user_image_widget.dart';
import 'package:my_profile/presentation/screens/home/widgets/user_info_widget.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _workExperienceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserProvider? userProvider;
  UserEntity userEntity = UserEntity();
  UserEntity editedUserEntity = UserEntity();

  @override
  void initState() {
    userProvider?.isEdit = false;
    userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController.text = userProvider?.userEntity.userName ?? '';
    _emailController.text = userProvider?.userEntity.email ?? '';
    _workExperienceController.text =
        "${userProvider?.userEntity.workExperience ?? 0}" ?? '';
    userEntity = userProvider!.userEntity;
    editedUserEntity = userEntity;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _workExperienceController.dispose();
    userProvider?.discardScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (userProvider?.isEdit == true) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return getDialog();
                    },
                  );
                } else {
                  Navigator.pop(context);
                }
              }),
          title: Text(context.getString(StringKeys.EDIT_PROFILE_TITLE)),
          backgroundColor: Color(0xFFFAA538),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Consumer<UserProvider>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      UserImageWidget(onClickEdit: () {}),
                      SizedBox(height: 24),
                      NameWidget(
                        onChange: (value) {
                          editedUserEntity.userName = value;
                          userProvider?.isEdit = true;
                        },
                        onClickEdit: () {
                          userProvider?.onEditField(EditProfileField.NAME);
                        },
                        isEditable:
                            value.editProfileField == EditProfileField.NAME,
                        controller: _nameController,
                        userEntity: userEntity,
                      ),
                      SizedBox(height: 12),
                      if (value.editProfileField == EditProfileField.EMAIL)
                        CustomTextFieldWidget(
                            autoFocus: true,
                            rightSpacing: 0,
                            leftSpacing: 0,
                            controller: _emailController,
                            onChanged: (value) {
                              editedUserEntity.email = value;
                              userProvider?.isEdit = true;
                            },
                            keyboardType: TextInputType.emailAddress,
                            hintText: context.getString(StringKeys.EMAIL_LABEL),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return context.getString(
                                    StringKeys.EMPTY_EMAIL_ERROR_MESSAGE);
                              }
                              return null;
                            })
                      else
                        UserInfoWidget(
                          controller: _emailController,
                          label: context.getString(StringKeys.EMAIL_LABEL),
                          value: userEntity.email ?? '',
                          onClickEdit: () {
                            userProvider?.onEditField(EditProfileField.EMAIL);
                          },
                        ),
                      SizedBox(height: 12),
                      if (value.editProfileField ==
                          EditProfileField.WORK_EXPERIENCE)
                        CustomTextFieldWidget(
                            autoFocus: true,
                            rightSpacing: 0,
                            leftSpacing: 0,
                            controller: _workExperienceController,
                            keyboardType: TextInputType.numberWithOptions(),
                            hintText: context
                                .getString(StringKeys.WORK_EXPERIENCE_LABEL),
                            onChanged: (value) {
                              if (value.isNotEmpty)
                                editedUserEntity.workExperience =
                                    int.tryParse(value);
                              userProvider?.isEdit = true;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return context.getString(StringKeys
                                    .EMPTY_WORK_EXPERIENCE_ERROR_MESSAGE);
                              }
                              return null;
                            })
                      else
                        UserInfoWidget(
                          label: context
                              .getString(StringKeys.WORK_EXPERIENCE_LABEL),
                          value:
                              "${userProvider?.userEntity.workExperience} ${context.getString(StringKeys.YEARS_LABEL)}",
                          onClickEdit: () {
                            userProvider
                                ?.onEditField(EditProfileField.WORK_EXPERIENCE);
                          },
                        ),
                      SizedBox(height: 12),
                      SkillsWidget(
                        isAddSkill: (value) {
                          editedUserEntity.skills?.add(value);
                          userProvider?.isEdit = true;
                        },
                        label: context.getString(StringKeys.SKILLS_LABEL),
                        skillsList: userEntity.skills,
                        isEditable:
                            value.editProfileField == EditProfileField.SKILLS,
                        onClickEdit: () {
                          userProvider?.onEditField(EditProfileField.SKILLS);
                        },
                      ),
                      SizedBox(height: 32),
                      CustomOrangeButtonWidget(
                        title: context.getString(StringKeys.SAVE_BUTTON),
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            userProvider?.setUserData(editedUserEntity);
                            Navigator.pop(context);
                          }
                        },
                        horizontalSpacing: 32,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  getDialog() {
    return AlertDialog(
      title: Text(context.getString(StringKeys.ALERT)),
      content: Text(context.getString(StringKeys.ALERT_MESSAGE)),
      actions: <Widget>[
        TextButton(
          child: Text(context.getString(StringKeys.CANCEL)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(context.getString(StringKeys.DISCARD)),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
