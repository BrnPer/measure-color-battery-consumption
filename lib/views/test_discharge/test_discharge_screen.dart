import 'package:flutter/material.dart';
import 'package:measure_color_battery_consumption/common/widgets/color_picker.dart';
import 'package:measure_color_battery_consumption/controllers/test_discharge_screen_controller.dart';
import 'package:measure_color_battery_consumption/views/test_discharge/test_discharge_timer.dart';
import 'package:measure_color_battery_consumption/views/test_discharge/test_discharge_information.dart';
import 'package:rx_notifier/rx_notifier.dart';

class TestDischarge extends StatefulWidget {
  TestDischarge({Key? key}) : super(key: key);

  @override
  _TestDischargeState createState() => _TestDischargeState();
}

class _TestDischargeState extends State<TestDischarge> {
  final TestDischargeScreenController controller =
      TestDischargeScreenController();

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (_) {
      return Scaffold(
        backgroundColor: controller.color.value,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: controller.showingInformation.value == true
                ? TestDischargeInformation(
                    onButtonPress: controller.onConfirmStartClick)
                : (controller.showingCountdown.value == true)
                    ? TestDischargeTimer(
                        onButtonPress: controller.onTimerFinished)
                    : Flex(
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
                                  'Test Discharging Now \r\n\r\n ${controller.currentDischargeValue.value} mA',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: (controller.color.value ==
                                              Colors.white)
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
                                onColorClick: (color) =>
                                    controller.changeColors(color)),
                          ),
                        ],
                      ),
          ),
        ),
      );
    });
  }
}
