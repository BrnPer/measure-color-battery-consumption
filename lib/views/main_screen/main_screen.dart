import 'package:flutter/material.dart';
import 'package:measure_color_battery_consumption/controllers/main_controller.dart';
import 'package:measure_color_battery_consumption/views/main_screen/widgets/color_picker.dart';
import 'package:rx_notifier/rx_notifier.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainController controller = MainController();

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (_) {
      return Scaffold(
        backgroundColor: controller.color.value,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                Flexible(
                  flex: 6,
                  child: Center(
                    child: RxBuilder(builder: (_) {
                      return Text(
                        'Current Discharging Now \r\n\r\n ${controller.currentDischargeValue.value} mA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: (controller.color.value == Colors.white)
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20),
                      );
                    }),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ColorPicker(
                      colors: controller.colors,
                      selectedColor: controller.color.value,
                      onColorClick: (color) => controller.changeColors(color)),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
