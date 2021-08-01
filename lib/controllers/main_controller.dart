import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class MainController {

  var color = RxNotifier<Color>(Colors.black);

  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.white,
    Colors.grey,
    Colors.green
  ];

}
