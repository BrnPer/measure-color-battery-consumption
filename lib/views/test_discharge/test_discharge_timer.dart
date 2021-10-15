import 'package:flutter/material.dart';

class TestDischargeTimer extends StatefulWidget {
  const TestDischargeTimer({Key? key, required this.onButtonPress})
      : super(key: key);

  final VoidCallback onButtonPress;
  @override
  State<TestDischargeTimer> createState() => _TestDischargeTimerState();
}

class _TestDischargeTimerState extends State<TestDischargeTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  int timerValue = 3;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);

    animation = Tween<double>(begin: 200, end: 0).animate(controller);

    //Listen for controller changes and update UI
    controller.addListener(() {
      setState(() {});
    });

    //Starts controller
    controller.forward();

    //Listen for updates
    controller.addStatusListener((status) {
      //When animation completed
      if (status == AnimationStatus.completed) {
        //If timer greater than 1
        if (timerValue > 1) {
          //Decrease timer
          setState(() {
            timerValue--;
          });

          controller.reset(); //Reset animation
          controller.forward(); //Start animation again
        } else {
          this.widget.onButtonPress();
        }
      }
    });
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Text(
          timerValue.toString(),
          style: TextStyle(color: Colors.white, fontSize: animation.value),
        );
      },
    ));
  }
}
