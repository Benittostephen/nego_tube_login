import 'package:flutter/material.dart';

import '../constants/const.dart';
import '../widgets/my_textfield.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    // This is the email validator
    String? _validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email';
      }
      return null;
    }

    // This function can be called when submitting the form
    void _submitForm(BuildContext context) {
      if (_formKey.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(
                    email: emailController.text.toLowerCase()))).then((_) {
          emailController.clear();
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(backgroundColor: Colors.white, title: const Text('LOGIN')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(height: 150.0),
                  const SizedBox(height: 70.0),
                  Image.asset('packages/tube_login/assets/icons/heart.png',
                      scale: 5),
                  const Text(
                    'Get started',
                    textHeightBehavior: TextHeightBehavior(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold, height: 0.8),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Login to continue',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 70.0),
                  MyTextfield(
                      controller: emailController,
                      hintText: 'Email',
                      validator: _validateEmail),
                  const SizedBox(height: 10.0),
                  InkWell(
                    onTap: () {
                      _submitForm(context);
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Ink(
                      height: 45,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 18)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Expanded(child: Divider())
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  myButton(
                      text: 'Continue with google',
                      icon: 'assets/icons/google.webp'),
                  // const SizedBox(height: 10.0),
                  // myButton('Continue With Facebook', 'assets/icons/facebook.png'),
                  const SizedBox(height: 10.0),

                  // const Spacer(),
                  const SizedBox(height: 70),
                  const Text('by continuing, you agree to our'),
                  const SizedBox(height: 8.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textButton('term of service', () {}),
                      const SizedBox(width: 15.0),
                      textButton('privacy policy', () {}),
                      const SizedBox(width: 15.0),
                      textButton('content policies', () {}),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    'Powered By Heartinz \n©2020 Heartinz Technologies Pvt Ltd',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector textButton(String text, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(text,
          style: const TextStyle(
              shadows: [Shadow(offset: Offset(0, -4), color: Colors.grey)],
              fontSize: 12,
              decoration: TextDecoration.underline,
              color: Colors.transparent,
              decorationThickness: 1.5,
              decorationColor: Colors.grey)),
    );
  }

  Widget myButton({required String text, String? icon, bool? boldText}) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: () {},
      child: Ink(
        height: 45,
        decoration: BoxDecoration(
            color: primaryColor_50, borderRadius: BorderRadius.circular(10.0)),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Image.asset(
                    icon,
                    height: 20,
                  )
                : const SizedBox(),
            const SizedBox(width: 10.0),
            Text(
              text,
              style: TextStyle(color: primaryColor),
            ),
          ],
        )),
      ),
    );
  }
}
