import 'package:measure_color_battery_consumption/helpers/messaging_helper.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BrightnessService {
  Future<MessagingHelper<double>> getCurrent() async {
    var result = new MessagingHelper<double>(false, "", 0);

    try {
      var brightness = await ScreenBrightness.current;

      result.success = true;
      result.obj = brightness;
    } catch (e) {
      result.success = false;
      result.message = "Could not get the brightness level";
    }

    return result;
  }

  Future<bool> setToValue(int valueInPercentage) async {
    try {
      await ScreenBrightness.setScreenBrightness(valueInPercentage / 100);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setToLowest() async {
    try {
      await ScreenBrightness.setScreenBrightness(0);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setToHighest() async {
    try {
      await ScreenBrightness.setScreenBrightness(1);
      return true;
    } catch (e) {
      return false;
    }
  }
}
