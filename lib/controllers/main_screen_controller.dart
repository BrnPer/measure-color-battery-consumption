import 'package:flutter/cupertino.dart';

class MainScreenController {
  void onStartTestClick(BuildContext context) {
    Navigator.pushNamed(context, '/test_discharge');
  }

  void onShowCurrentEnergyClick(BuildContext context) {
    Navigator.pushNamed(context, '/current_energy');
  }
}
