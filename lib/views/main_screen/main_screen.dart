import 'package:flutter/material.dart';
import 'package:measure_color_battery_consumption/common/widgets/my_button.dart';
import 'package:measure_color_battery_consumption/controllers/main_screen_controller.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainScreenController controller = MainScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: [
                  Text("Measure",
                      style: TextStyle(color: Colors.white, fontSize: 35)),
                  Icon(
                    Icons.battery_saver,
                    color: Colors.green,
                    size: 60,
                  ),
                  Text("Consumption",
                      style: TextStyle(color: Colors.white, fontSize: 35)),
                ],
              ),
              SizedBox(
                height: 150,
              ),
              MyButton(
                onButtonPress: controller.onStartTestClick,
                text: "Start Test",
                mainButton: true,
              ),
              SizedBox(
                height: 30,
              ),
              MyButton(
                onButtonPress: () {
                  controller.onShowCurrentEnergyClick(context);
                },
                text: "See Current Energy",
                mainButton: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
