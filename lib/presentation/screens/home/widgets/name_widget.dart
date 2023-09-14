import 'package:flutter/material.dart';
import 'package:my_profile/domain/entities/user/user_entity.dart';
import 'package:my_profile/presentation/common/utils/app_constants.dart';
import 'package:my_profile/presentation/common/utils/extensions.dart';
import 'package:my_profile/presentation/common/widgets/custom_textfield.dart';
import 'package:my_profile/presentation/localization/string_keys.dart';

class NameWidget extends StatelessWidget {
  final VoidCallback? onClickEdit;
  final bool isEditable;
  final TextEditingController? controller;
  final UserEntity userEntity;
  final ValueChanged onChange;

  const NameWidget(
      {Key? key,
      this.onClickEdit,
      this.isEditable = false,
      this.controller,
      required this.userEntity,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEditable
        ? CustomTextFieldWidget(
            rightSpacing: 0,
            leftSpacing: 0,
            controller: controller,
            autoFocus: true,
            hintText: context.getString(StringKeys.USERNAME_HINT),
            onChanged: (value) {
              onChange(value);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return context
                    .getString(StringKeys.EMPTY_USERNAME_ERROR_MESSAGE);
              }
              return null;
            })
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userEntity.userName ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (onClickEdit != null) ...{
                SizedBox(width: 4),
                IconButton(
                  onPressed: () {
                    onClickEdit!();
                  },
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(maxWidth: 16, maxHeight: 16),
                  alignment: Alignment.center,
                  splashRadius: 16,
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppConstants.lightOrange,
                    size: 16,
                  ),
                ),
              }
            ],
          );
  }
}
