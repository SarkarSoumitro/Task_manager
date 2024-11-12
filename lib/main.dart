import 'package:flutter/material.dart';
import 'package:module_14_task_management/component/newTaskList.dart';
import 'package:module_14_task_management/screen/onboarding/emailVerificationScreen.dart';
import 'package:module_14_task_management/screen/onboarding/loginScreen.dart';
import 'package:module_14_task_management/screen/onboarding/pinVerificationScreen.dart';
import 'package:module_14_task_management/screen/onboarding/registrationScreen.dart';
import 'package:module_14_task_management/screen/onboarding/setPasswordScreen.dart';
import 'package:module_14_task_management/screen/task/homeScreen.dart';
import 'package:module_14_task_management/screen/task/taskCreateScreen.dart';
import 'package:module_14_task_management/utility/utility.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await ReadUserData('token');
  if (token == null) {
    runApp(Myapp('/login'));
  } else {
    runApp(Myapp('/newTaskList'));
  }
}

class Myapp extends StatelessWidget {
  final String FirstRout;

  const Myapp(this.FirstRout);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/': (context) => homeScreen(),
        '/login': (context) => LoginScreen(),
        '/registration': (context) => registrationScreen(),
        '/emailVerification': (context) => emailVerificationScreen(),
        '/pinVerification': (context) => pinVerificationScreen(),
        '/setPassword': (context) => setPasswordScreen(),
        '/newTaskList': (context) => newTaskList(),
        '/taskCreate': (context) => taskCreateScreen()
      },
    );
  }
}
