import 'package:flutter/material.dart';
import 'package:measure_color_battery_consumption/common/widgets/my_button.dart';

class TestDischargeInformation extends StatelessWidget {
  const TestDischargeInformation({Key? key, required this.onButtonPress})
      : super(key: key);

  final String informationText = """The test will take about 5 minutes.
      \r\nTo get better results you should: 
      \r\n- Turn on airplane mode\r\n- Close background tasks\r\n- Disable auto-brightness      
      \r\nDuring the test, screen brightness will change and your phone shouldn't be charging.
  """;

  final VoidCallback onButtonPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              children: [
                Text(
                  "Information",
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  informationText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                MyButton(
                    text: "Start",
                    mainButton: true,
                    onButtonPress: onButtonPress)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
