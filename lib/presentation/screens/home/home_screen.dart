import 'package:flutter/material.dart';
import 'package:my_profile/data/common/preferences.dart';
import 'package:my_profile/presentation/common/utils/app_constants.dart';
import 'package:my_profile/presentation/common/utils/extensions.dart';
import 'package:my_profile/presentation/localization/string_keys.dart';
import 'package:my_profile/presentation/providers/user/user_provider.dart';
import 'package:my_profile/presentation/screens/home/widgets/name_widget.dart';
import 'package:my_profile/presentation/screens/home/widgets/skills_widget.dart';
import 'package:my_profile/presentation/screens/home/widgets/user_image_widget.dart';
import 'package:my_profile/presentation/screens/home/widgets/user_info_widget.dart';
import 'package:my_profile/presentation/screens/login/login_screen.dart';
import 'package:my_profile/presentation/screens/profile/edit_profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.getString(StringKeys.HOME_TITLE)),
          backgroundColor: Color(0xFFFAA538),
          actions: [
            IconButton(
              onPressed: () {
                _navigateToEditProfileScreen();
              },
              icon: Icon(
                Icons.edit_outlined,
                color: AppConstants.white,
              ),
            ),
            IconButton(
              icon: Icon(Icons.logout_outlined),
              alignment: Alignment.center,
              onPressed: () {
                _onLogout();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Consumer<UserProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    UserImageWidget(),
                    SizedBox(height: 8),
                    NameWidget(
                      userEntity: value.userEntity,
                      onChange: (value) {},
                    ),
                    SizedBox(height: 24),
                    UserInfoWidget(
                      label: context.getString(StringKeys.EMAIL_LABEL),
                      value: value.userEntity.email ?? '',
                    ),
                    SizedBox(height: 12),
                    UserInfoWidget(
                      label:
                          context.getString(StringKeys.WORK_EXPERIENCE_LABEL),
                      value:
                          "${value.userEntity.workExperience} ${context.getString(StringKeys.YEARS_LABEL)}",
                    ),
                    SizedBox(height: 12),
                    SkillsWidget(
                      label: context.getString(StringKeys.SKILLS_LABEL),
                      skillsList: value.userEntity.skills,
                      isAddSkill: (value) {},
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _onLogout() async {
    context.clearProviderData();
    await Preferences().clearData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  _navigateToEditProfileScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return EditProfileScreen();
        },
      ),
    );
  }
}
