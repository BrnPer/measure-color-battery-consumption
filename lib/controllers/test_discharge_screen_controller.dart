import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';
import 'package:measure_color_battery_consumption/helpers/messaging_helper.dart';
import 'package:rx_notifier/rx_notifier.dart';

class TestDischargeScreenController {
  var showingInformation = RxNotifier<bool>(true);
  var color = RxNotifier<Color>(Colors.black);
  var showingCountdown = RxNotifier<bool>(false);

  var currentDischargeValue = RxNotifier<double?>(null);

  late Timer periodicTimer;
  final Duration interval = const Duration(milliseconds: 250);

  TestDischargeScreenController() {
    periodicTimer =
        new Timer.periodic(interval, (Timer t) => changeDischargeAmount());
  }

  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.white,
    Colors.grey,
    Colors.green
  ];

  changeColors(Color newColor) {
    color.value = newColor;
  }

  changeDischargeAmount() async {
    var response = await getCurrentDischargeAmount();

    if (response.success == true) {
      currentDischargeValue.value = response.obj;
    }
  }

  dispose() {
    periodicTimer.cancel();
  }

  Future<MessagingHelper<double?>> getCurrentDischargeAmount() async {
    var response = MessagingHelper<double?>(false, "", null);
    try {
      var androidBatteryInformation =
          await BatteryInfoPlugin().androidBatteryInfo;

      if (androidBatteryInformation != null) {
        //Should be converted from microamperes to milliamperes
        response.obj = androidBatteryInformation.currentNow! / 1000;
        response.success = true;
      }
    } catch (e) {
      response.success = false;
      response.message = "Couldn't get the right value";
    }

    return response;
  }

  onConfirmStartClick() {
    showingInformation.value = false;
    showingCountdown.value = true;
  }

  onTimerFinished() {
    showingCountdown.value = false;
  }
}
