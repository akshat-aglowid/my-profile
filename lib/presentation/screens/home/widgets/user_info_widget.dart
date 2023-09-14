import 'package:flutter/material.dart';
import 'package:my_profile/presentation/common/utils/app_constants.dart';

class UserInfoWidget extends StatefulWidget {
  final String label;
  final String value;
  final VoidCallback? onClickEdit;
  final TextEditingController? controller;

  const UserInfoWidget(
      {Key? key,
      required this.label,
      required this.value,
      this.onClickEdit,
      this.controller})
      : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppConstants.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                    fontSize: 12,
                    color: AppConstants.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.value,
                style: TextStyle(
                  fontSize: 16,
                  color: AppConstants.darkGrey,
                ),
              )
            ],
          ),
          if (widget.onClickEdit != null)
            IconButton(
              onPressed: () {
                widget.onClickEdit!();
              },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(maxWidth: 24, maxHeight: 24),
              alignment: Alignment.center,
              splashRadius: 16,
              icon: Icon(
                Icons.edit_outlined,
                color: AppConstants.orange,
              ),
            ),
        ],
      ),
    );
  }
}
