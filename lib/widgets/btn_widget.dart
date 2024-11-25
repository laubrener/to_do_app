import 'package:flutter/material.dart';

class BtnWidget extends StatefulWidget {
  final String title;
  final Function onPressed;
  final Color? color;
  final Color? textColor;

  const BtnWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = Colors.deepPurpleAccent,
    this.textColor = Colors.white,
  });

  @override
  State<BtnWidget> createState() => _BtnWidgetState();
}

class _BtnWidgetState extends State<BtnWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: MaterialButton(
        onPressed: () => widget.onPressed(),
        elevation: 2,
        highlightElevation: 5,
        shape: const StadiumBorder(),
        color: widget.color,
        height: 50,
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: widget.textColor, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
