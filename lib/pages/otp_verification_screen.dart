import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../constants/const.dart';
import 'login_screen.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String email;

  OtpVerificationScreen({super.key, required this.email}) {
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timerNotifier.value = 15; // Reset the timer to 15 seconds
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_timerNotifier.value == 0) {
        timer.cancel();
      } else {
        _timerNotifier.value -= 1;
      }
    });
  }

  final TextEditingController _otpController = TextEditingController();
  final ValueNotifier<int> _timerNotifier = ValueNotifier<int>(15);
  Timer? _timer;

  // This method verifies the OTP
  void _verifyOTP(BuildContext context) {
    final otp = _otpController.text;
    if (otp.length == 6) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      print("Entered OTP: $otp");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('OTP Verified')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid OTP')));
    }
  }

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
        color: primaryColor_50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent)),
  );

  @override
  Widget build(BuildContext context) {
    // Focused pin theme
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70.0),
              Image.asset('packages/tube_login/assets/icons/heart.png',
                  scale: 5),
              const Text(
                'OTP Verification',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'An 6 digit OTP has been sent to your email',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  email,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 50),
              Pinput(
                length: 6,
                controller: _otpController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,
                onCompleted: (pin) => _verifyOTP(context),
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  _verifyOTP(context);
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
                        'Verify OTP',
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
              const SizedBox(height: 30),
              ValueListenableBuilder<int>(
                valueListenable: _timerNotifier,
                builder: (context, value, child) {
                  return GestureDetector(
                      onTap: () {
                        if (_timerNotifier.value == 0) {
                          _startTimer();
                        }
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: value == 0 ? 'Resend OTP' : 'Re-send code in ',
                          style: TextStyle(fontSize: 11, color: Colors.black),
                        ),
                        TextSpan(
                          text: value == 0 ? '' : '0:${value}s',
                          style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ])));
                },
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      )

          /*Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        child: const Icon(Icons.arrow_back_ios, size: 30),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Image.asset('assets/icons/heart.png', scale: 5)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      'OTP Verification',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'An 6 digit OTP has been sent to your email',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        email,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Pinput(
                      length: 6,
                      controller: _otpController,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      cursor: Text(
                        '|',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onCompleted: (pin) => _verifyOTP(context),
                    ),
                    const SizedBox(height: 50),
                    Material(
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: () {
                          _verifyOTP(context);
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Ink(
                          height: 45,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text(
                              'Verify OTP',
                              style: TextStyle(
                                  color: primaryColor_50,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Resend OTP',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),*/
          ),
    );
  }
}
