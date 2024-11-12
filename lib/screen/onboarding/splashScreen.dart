import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_14_task_management/style/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ScreenBackground(context),
        Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: SvgPicture.asset(
              'images/task.svg',
              alignment: Alignment.center,
              height: 170,
              width: 170,
            ),
          ),
        )
      ],
    ));
  }
}
