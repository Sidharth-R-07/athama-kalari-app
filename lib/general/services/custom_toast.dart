import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class CustomToast {
  static void successToast({
    required String message,
    PreferDirection? preferDirection,
  }) {
    // ignore: cascade_invocations
    BotToast.showAttachedWidget(
      // set animation top to bottom
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
      attachedBuilder: (_) => Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: const Offset(0, 0.5), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 40,
          maxHeight: 100,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
      preferDirection: preferDirection ?? PreferDirection.bottomCenter,
      enableSafeArea: true,
      enableKeyboardSafeArea: true,
      target: const Offset(520, 520),
      
    );
  }

  static void errorToast({
    required String message,
    PreferDirection? preferDirection,
  }) {
    BotToast.showAttachedWidget(
      // set animation top to bottom
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),

      attachedBuilder: (_) => Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: const Offset(0, 0.5), // changes position of shadow
            ),
          ],
        ),
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 40,
          // maxHeight: 100,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
      target: const Offset(520, 520),
      preferDirection: preferDirection ?? PreferDirection.topCenter,
    );
  }
}
