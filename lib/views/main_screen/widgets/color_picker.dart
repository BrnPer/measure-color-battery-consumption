import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  ColorPicker(
      {Key? key,
      required this.colors,
      required this.onColorClick})
      : super(key: key);

  List<Color> colors;
  Function onColorClick;

  Color getAppropriateColor(Color color) {
    if (color == Colors.white) return Colors.black;
    if (color == Colors.grey) return Colors.yellow;
    return Colors.white;
  }

  Widget colorComponent(Color color) {
    return GestureDetector(
      onTap: () {
        onColorClick(color);
      },
      child: Container(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 50,
          width: 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Colors",
          style: TextStyle(
              color: getAppropriateColor(selectedColor), fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 5,
          children: [for (Color color in colors) colorComponent(color)],
        ),
      ],
    );
  }
}
