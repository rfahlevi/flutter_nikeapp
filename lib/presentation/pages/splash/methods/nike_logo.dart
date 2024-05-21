import 'package:flutter/material.dart';

import '../../../misc/nike_font.dart';
import '../../../misc/spacing.dart';

Widget nikeLogo({
  required BuildContext context,
  double? width,
  double? fontSize,
}) =>
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/logo.png',
            width: width ?? MediaQuery.of(context).size.width / 5,
          ),
          verticalSpace(14),
          Text(
            'Nike App',
            style: NikeFont.h1SemiBold().copyWith(
              fontSize: fontSize ?? 40,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
