import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isPasswordField;
  final bool isShowSuffixIcon;
  final FormFieldValidator<String> validator;
  final double leftSpacing;
  final double rightSpacing;
  final TextInputType keyboardType;
  final int maxLines;
  final int minLines;
  final String suffixIcon;
  final String suffixText;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFieldWidget({
    this.controller,
    required this.hintText,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    required this.validator,
    this.leftSpacing = 30.0,
    this.rightSpacing = 30.0,
    this.maxLines = 1,
    this.minLines = 1,
    this.isShowSuffixIcon = false,
    this.suffixIcon = "",
    this.suffixText = "",
    this.autoFocus = false,
    this.onChanged,
  });

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:
          EdgeInsets.only(left: widget.leftSpacing, right: widget.rightSpacing),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.next,
        validator: widget.validator,
        controller: widget.controller,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        autofocus: widget.autoFocus,
        obscureText: _isPasswordControl(),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          border: InputBorder.none,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Color(0xFF9EA0A7),
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: Visibility(
            visible: widget.isShowSuffixIcon,
            child: widget.isPasswordField
                ? IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xFFA5ACBB),
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                : Container(
                    padding: EdgeInsets.all(14.0),
                    child: widget.suffixIcon.isNotEmpty &&
                            widget.suffixText.isEmpty
                        ? Image.asset(
                            widget.suffixIcon,
                            width: 15,
                            height: 15,
                          )
                        : Text(
                            widget.suffixText,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF616161),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
          ),
        ),
      ),
    );
  }

  bool _isPasswordControl() {
    if (widget.isPasswordField) {
      return _isObscure;
    }
    return false;
  }
}
