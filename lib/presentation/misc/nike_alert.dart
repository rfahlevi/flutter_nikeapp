import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_font.dart';

class NikeAlert {
  static successful({required BuildContext context, required String content}) {
    return context.showFlash(
      barrierDismissible: true,
      duration: const Duration(seconds: 3),
      builder: (context, controller) => FlashBar(
        controller: controller,
        elevation: 1,
        forwardAnimationCurve: Curves.easeInCirc,
        reverseAnimationCurve: Curves.bounceIn,
        position: FlashPosition.top,
        indicatorColor: const Color(0XFF198754),
        backgroundColor: const Color(0XFF198754),
        icon: const Icon(Icons.error_rounded, color: Colors.white),
        title: Text(
          'Success!',
          style: NikeFont.h4SemiBold().copyWith(color: Colors.white),
        ),
        content: Text(
          content,
          style: NikeFont.h4Medium().copyWith(color: Colors.white),
        ),
      ),
    );
  }

  static notice({required BuildContext context, required String content}) {
    return context.showFlash(
      barrierDismissible: true,
      duration: const Duration(seconds: 3),
      builder: (context, controller) => FlashBar(
        controller: controller,
        elevation: 1,
        forwardAnimationCurve: Curves.easeInCirc,
        reverseAnimationCurve: Curves.bounceIn,
        position: FlashPosition.top,
        indicatorColor: Colors.amber,
        backgroundColor: Colors.amber,
        icon: const Icon(Icons.error_rounded, color: Colors.black87),
        title: Text(
          'Warning!',
          style: NikeFont.h4SemiBold().copyWith(color: Colors.black87),
        ),
        content: Text(
          content,
          style: NikeFont.h4Medium().copyWith(color: Colors.black87),
        ),
      ),
    );
  }

  static error({required BuildContext context, required String content}) {
    return context.showFlash(
      barrierDismissible: true,
      duration: const Duration(seconds: 3),
      builder: (context, controller) => FlashBar(
        controller: controller,
        elevation: 1,
        forwardAnimationCurve: Curves.easeInCirc,
        reverseAnimationCurve: Curves.bounceIn,
        position: FlashPosition.top,
        indicatorColor: Colors.red,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error_rounded, color: Colors.white),
        title: Text(
          'Error!',
          style: NikeFont.h4SemiBold().copyWith(color: Colors.white),
        ),
        content: Text(
          content,
          style: NikeFont.h4Medium().copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
