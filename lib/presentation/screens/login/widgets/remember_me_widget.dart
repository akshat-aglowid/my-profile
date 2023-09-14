import 'package:flutter/material.dart';
import 'package:my_profile/presentation/common/utils/extensions.dart';
import 'package:my_profile/presentation/localization/string_keys.dart';
import 'package:my_profile/presentation/providers/login/login_provider.dart';
import 'package:provider/provider.dart';

class RememberMeWidget extends StatefulWidget {
  const RememberMeWidget({Key? key}) : super(key: key);

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xFFFA7F25)),
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    activeColor: Color(0xFFFA7F25),
                    value: value.isRememberedMe,
                    onChanged: (value) {
                      Provider.of<LoginProvider>(context, listen: false)
                          .onChangeRemember(value ?? false);
                    },
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                context.getString(StringKeys.REMEMBERED_ME),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
