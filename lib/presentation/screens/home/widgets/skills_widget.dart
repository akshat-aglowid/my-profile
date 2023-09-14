import 'package:flutter/material.dart';
import 'package:my_profile/presentation/common/utils/app_constants.dart';
import 'package:my_profile/presentation/common/utils/extensions.dart';
import 'package:my_profile/presentation/common/widgets/custom_textfield.dart';
import 'package:my_profile/presentation/localization/string_keys.dart';

class SkillsWidget extends StatefulWidget {
  final String label;
  final List<String>? skillsList;
  final VoidCallback? onClickEdit;
  final bool isEditable;
  final ValueChanged isAddSkill;
  const SkillsWidget({
    Key? key,
    required this.label,
    this.skillsList,
    this.onClickEdit,
    this.isEditable = false, required this.isAddSkill,
  }) : super(key: key);

  @override
  State<SkillsWidget> createState() => _SkillsWidgetState();
}

class _SkillsWidgetState extends State<SkillsWidget> {
  final _skillController = TextEditingController();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
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
                if (widget.isEditable) ...{
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldWidget(
                            autoFocus: true,
                            rightSpacing: 0,
                            leftSpacing: 0,
                            controller: _skillController,
                            hintText:
                                context.getString(StringKeys.SKILLS_LABEL),
                            validator: (value) {
                              return null;
                            }),
                      ),
                      // SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          widget.isAddSkill(_skillController.text.trim());
                          // widget.skillsList?.add(_skillController.text.trim());
                          setState(() {});
                          _skillController.clear();
                        },
                      ),
                    ],
                  ),
                },
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.skillsList!.map((item) {
                    return Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      elevation: 0,
                      label: Text(
                        item,
                        style: TextStyle(
                            fontSize: 16, color: AppConstants.darkGrey),
                      ),
                      onDeleted: widget.isEditable
                          ? () {
                              widget.skillsList!.remove(item);
                              setState(() {});
                            }
                          : null,
                    );
                  }).toList(),
                )
              ],
            ),
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
