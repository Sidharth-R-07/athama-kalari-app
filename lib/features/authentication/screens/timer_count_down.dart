import 'dart:async';

import 'package:athma_kalari_app/features/authentication/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../general/utils/app_colors.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  int _secondsRemaining = 60; // Initial countdown time in seconds
  late Timer _timer;

  void startCountdown() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_secondsRemaining == 0) {
          Provider.of<AuthProvider>(context, listen: false).showResendToken();
          timer.cancel();
        } else {
          setState(() {
            _secondsRemaining--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _secondsRemaining == 0
          ? const SizedBox()
          : Text(
              "00:${_secondsRemaining}s",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}
