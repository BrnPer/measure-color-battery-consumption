import 'package:flutter/cupertino.dart';

class MainScreenController {
  void onStartTestClick() {
    print("Stat Test Button");
  }

  void onShowCurrentEnergyClick(BuildContext context) {
    print("See Current Energy Button");
    Navigator.pushNamed(context, '/current_energy');
  }
}
