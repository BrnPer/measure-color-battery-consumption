import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:measure_color_battery_consumption/helpers/messaging_helper.dart';
import 'package:measure_color_battery_consumption/services/brightness_service.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:wakelock/wakelock.dart';

class TestDischargeScreenController {
  var showingInformation = RxNotifier<bool>(true);
  var color = RxNotifier<Color>(Colors.black);
  var showingCountdown = RxNotifier<bool>(false);

  var currentDischargeValue = RxNotifier<double?>(null);

  final List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.white,
    Colors.grey,
    Colors.green
  ];

  final Duration interval = const Duration(milliseconds: 250);
  late int currentColor = 0;
  late Timer periodicTimer;
  int currentBrightnessLevel = 0;
  final List<int> listOfBrightnessLevels = [50, 100, 25, 75];

  final BrightnessService brightnessService = BrightnessService();
  final int timeInSameBrightness = 15;
  late Timer brightnessTimer;

  final int timeInSameColor = 60;
  late Timer colorTimer;

  TestDischargeScreenController() {}

  start() {
    changeColor(colors[currentColor]);

    Wakelock.enable(); //Prevent Screen from locking

    periodicTimer = new Timer.periodic(
        new Duration(milliseconds: 250), (timer) => calculateCurrentEnergy());

    //Set the start brightness to 50%
    brightnessService
        .setToValue(listOfBrightnessLevels[currentBrightnessLevel]);

    //Starts the brightness timer
    brightnessTimer = new Timer.periodic(
        new Duration(seconds: timeInSameBrightness),
        (Timer t) => changeBrightnessLevel());

    //Starts the color timer
    colorTimer = new Timer.periodic(new Duration(seconds: timeInSameColor),
        (timer) => changeCurrentColor());
  }

  stop() {
    Wakelock.disable();

    brightnessTimer.cancel();
    colorTimer.cancel();
    changeColor(Colors.black);
  }

  changeBrightnessLevel() {
    currentBrightnessLevel++;
    if (currentBrightnessLevel >= listOfBrightnessLevels.length) {
      currentBrightnessLevel = 0;
    }

    brightnessService
        .setToValue(listOfBrightnessLevels[currentBrightnessLevel]);
  }

  changeCurrentColor() {
    currentColor++;

    if (currentColor >= colors.length) {
      stop();
      return;
    }

    changeColor(colors[currentColor]);
  }

  changeColor(Color newColor) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: newColor, // navigation bar color
      statusBarColor: newColor, // status bar color
    ));
    color.value = newColor;
  }

  calculateCurrentEnergy() async {
    var response = await getCurrentDischargeAmount();

    if (response.success == true) {
      print(response.obj);
      currentDischargeValue.value = response.obj;
    }
  }

  dispose() {
    if (periodicTimer.isActive == true) periodicTimer.cancel();
    if (brightnessTimer.isActive == true) brightnessTimer.cancel();
    if (colorTimer.isActive == true) colorTimer.cancel();

    changeColor(Colors.black);
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
    start();
  }
}
