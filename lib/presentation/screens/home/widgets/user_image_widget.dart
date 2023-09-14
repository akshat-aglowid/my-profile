import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_profile/presentation/common/utils/app_constants.dart';
import 'package:my_profile/presentation/providers/user/user_provider.dart';
import 'package:provider/provider.dart';

class UserImageWidget extends StatefulWidget {
  final VoidCallback? onClickEdit;

  const UserImageWidget({Key? key, this.onClickEdit}) : super(key: key);

  @override
  State<UserImageWidget> createState() => _UserImageWidgetState();
}

class _UserImageWidgetState extends State<UserImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return Center(
          child: Stack(
            children: [
              _getUserImage(value),
              if (widget.onClickEdit != null)
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.gallery, value.isEdit);
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppConstants.lightOrange),
                      child: Icon(
                        Icons.edit_outlined,
                        color: AppConstants.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  _getUserImage(UserProvider value) {
    return value.userEntity.userImage != null &&
            value.userEntity.userImage!.isNotEmpty
        ? CircleAvatar(
            backgroundImage: FileImage(File(value.userEntity.userImage ?? '')),
            radius: 50,
            backgroundColor: AppConstants.orange,
          )
        : Container(
            width: 100,
            height: 100,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: AppConstants.grey),
            child: Icon(Icons.account_circle_outlined, size: 72));
  }

  _pickImage(ImageSource type, bool isEdit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: type);
    if (pickedFile != null) {
      isEdit = true;
      Provider.of<UserProvider>(context, listen: false)
          .onChangeUserImage(pickedFile.path);
    }
  }
}
