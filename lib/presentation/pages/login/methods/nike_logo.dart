import 'package:flutter/material.dart';

import '../../../misc/spacing.dart';
import '../../splash/methods/nike_logo.dart';

List<Widget> logo(BuildContext context) => [
      Center(
        child: nikeLogo(
          context: context,
          width: 100,
          fontSize: 24,
        ),
      ),
      verticalSpace(40),
    ];
