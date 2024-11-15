import 'package:flutter/material.dart';

class BtnWidget extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color? color;
  final Color? textColor;
  const BtnWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      this.color = Colors.deepPurpleAccent,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: MaterialButton(
        onPressed: () => onPressed(),
        elevation: 2,
        highlightElevation: 5,
        shape: const StadiumBorder(),
        color: color,
        height: 50,
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: textColor, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
