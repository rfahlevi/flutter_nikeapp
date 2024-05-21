import 'package:flutter/material.dart';

import '../../../misc/nike_font.dart';
import '../../../misc/spacing.dart';

List<Widget> loginTitle() => [
      Text(
        'Welcome',
        style: NikeFont.h2SemiBold(),
      ),
      Text(
        'Please login to continue our app',
        style: NikeFont.h4Regular(),
      ),
      verticalSpace(14),
    ];
