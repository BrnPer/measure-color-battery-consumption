import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      required this.text,
      required this.mainButton,
      required this.onButtonPress})
      : super(key: key);

  final String text;
  final bool mainButton;

  final VoidCallback onButtonPress;

  Color? getBackgroundColor() {
    if (mainButton == true) return Colors.blue[200];
    return Colors.white;
  }

  Color? getFontColor() {
    if (mainButton == true) return Colors.black;
    return Colors.black;
  }

  Color getShadowColor() {
    if (mainButton == true) return Colors.red.shade50.withOpacity(0.3);
    return Colors.green.withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPress,
      child: Container(
        decoration: BoxDecoration(
          color: getBackgroundColor(),
          boxShadow: [
            BoxShadow(
              color: getShadowColor(),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(2, 1), // changes position of shadow
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text(
            text,
            style: TextStyle(color: getFontColor(), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
