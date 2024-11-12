import 'package:flutter/material.dart';
import 'package:module_14_task_management/api/apiClient.dart';
import 'package:module_14_task_management/screen/task/homeScreen.dart';
import 'package:module_14_task_management/style/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, String> formValues = {"email": "", "password": ""};
  bool _isLoading = false;

  inputOnChange(String mapKey, String textValue) {
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    if (formValues['email']!.isEmpty) {
      ErrorToast("Email Required");
      return; // Exit the function if email is empty
    } else if (formValues['password']!.isEmpty) {
      ErrorToast("Password Required");
      return; // Exit the function if password is empty
    }

    setState(() {
      _isLoading = true;
    });

    bool res = await LoginRequest(formValues);

    setState(() {
      _isLoading =
          false; // Move this line outside to ensure it runs regardless of result
    });

    if (res == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  homeScreen()), // Replace with your actual screen
          (route) => false);
    } else {
      // You can show a specific error message here if you get any response back
      ErrorToast(
          "Login failed. Please try again."); // Modify based on your API response
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(context),
          Center(
            child: Container(
              child: _isLoading
                  ? (Center(
                      child: CircularProgressIndicator(),
                    ))
                  : (SingleChildScrollView(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get started with",
                            style: Head1Text(colorDarkBlue),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            "Learn with by Mistakes",
                            style: Head6Text(colorLightGray),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onChanged: (textValue) {
                              inputOnChange("email", textValue);
                            },
                            decoration: AppInputDecoration("Email address"),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onChanged: (textValue) {
                              inputOnChange("password", textValue);
                            },
                            decoration: AppInputDecoration("Password"),
                          ),
                          const SizedBox(height: 20),
                          _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  style: AppButtonStyle(),
                                  onPressed: formOnSubmit,
                                  child: SuccessButtonChild("Login"),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/emailVerification");
                                    },
                                    child: Text(
                                      'Forget Password?',
                                      style: Head7Text(colorLightGray),
                                    )),
                                SizedBox(height: 15),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/registration");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Don't have a account? ",
                                            style: Head7Text(colorDarkBlue)),
                                        Text(
                                          "Sign Up",
                                          style: Head7Text(colorGreen),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
            ),
          ),
        ],
      ),
    );
  }
}
