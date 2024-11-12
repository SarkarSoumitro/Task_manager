import 'package:flutter/material.dart';

import '../../api/apiClient.dart';
import '../../style/style.dart';

class emailVerificationScreen extends StatefulWidget {
  const emailVerificationScreen({super.key});

  @override
  State<emailVerificationScreen> createState() =>
      _emailVerificationScreenState();
}

class _emailVerificationScreenState extends State<emailVerificationScreen> {
  Map<String, String> FormValues = {"email": ""};
  bool Loading = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['email'] == null || FormValues['email']!.isEmpty) {
      ErrorToast('Email Required !');
    } else {
      setState(() {
        Loading = true;
      });
      bool res = await VerifyEmailRequest(FormValues['email']!);
      if (res == true) {
        Navigator.pushNamed(context, '/pinVerification');
      } else {
        ErrorToast('Verification failed. Please try again.');
        setState(() {
          Loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Email Address",
                  style: Head1Text(colorDarkBlue),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  "A 6 digit verification pin will be sent to your email address",
                  style: Head6Text(colorLightGray),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: AppInputDecoration("Email address"),
                  onChanged: (value) {
                    InputOnChange('email', value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: ElevatedButton(
                      style: AppButtonStyle(),
                      onPressed: () {
                        FormOnSubmit();
                      },
                      child: SuccessButtonChild(">")),
                )
              ],
            ),
          ),
          if (Loading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
