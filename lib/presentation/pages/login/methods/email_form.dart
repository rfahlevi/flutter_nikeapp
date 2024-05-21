import 'package:flutter/material.dart';

import '../../../extension/nike_form.dart';
import '../../../misc/spacing.dart';

List<Widget> emailForm(TextEditingController emailC) => [
      NikeForm(
        controller: emailC,
        label: 'Email',
        hintText: 'Enter your email',
      ),
      verticalSpace(14),
    ];
