import 'package:flutter/material.dart';

class CustomOrangeButtonWidget extends StatefulWidget {
  final VoidCallback onPress;
  final String title;
  final double horizontalSpacing;

  CustomOrangeButtonWidget({
    required this.title,
    required this.onPress,
    this.horizontalSpacing = 8,
  });

  @override
  _CustomOrangeButtonWidgetState createState() =>
      _CustomOrangeButtonWidgetState();
}

class _CustomOrangeButtonWidgetState extends State<CustomOrangeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: widget.horizontalSpacing),
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              colors: [Color(0xFFFA7F25), Color(0xFFFAA538)],
            ),
          ),
          child: TextButton(
            child: Text(
              '${widget.title}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: widget.onPress,
          ),
        ),
      ],
    );
  }
}
