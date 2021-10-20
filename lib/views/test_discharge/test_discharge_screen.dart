import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (_) {
      return Scaffold(
        backgroundColor: controller.color.value,
        body: Container(
          alignment: Alignment.center,
          child: controller.showingInformation.value == true
              ? TestDischargeInformation(
                  onButtonPress: controller.onConfirmStartClick)
              : (controller.showingCountdown.value == true)
                  ? TestDischargeTimer(
                      onButtonPress: controller.onTimerFinished)
                  : Center(
                      child: RxBuilder(builder: (_) {
                        return Text(
                          controller.currentDischargeValue.value != null
                              ? '${controller.currentDischargeValue.value} mA'
                              : "Measuring...",
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
      );
    });
  }
}
