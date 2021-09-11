import 'package:flutter/material.dart';
import 'package:measure_color_battery_consumption/views/discharge_screen/discharge_screen.dart';
import 'package:measure_color_battery_consumption/views/main_screen/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.red,
        primarySwatch: Colors.blue,
      routes: {
        "/": (context) => MainScreen(),
        "/current_energy": (context) => DischargeScreen()
      },
      initialRoute: "/",
    );
  }
}
