import 'package:flutter/material.dart';
import 'package:measure_color_battery_consumption/controllers/main_controller.dart';
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
