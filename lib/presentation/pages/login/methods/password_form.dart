import 'package:flutter/material.dart';

import '../../../extension/nike_form.dart';
import '../../../misc/spacing.dart';

List<Widget> passwordForm({
  required TextEditingController passwordC,
  required bool isHide,
  required Function togglePassword,
}) =>
    [
      NikeForm(
        controller: passwordC,
        label: 'Password',
        hintText: '********',
        obscureText: isHide,
        minLines: 1,
        maxLines: 1,
        suffixIcon: GestureDetector(
          onTap: () {
            togglePassword();
          },
          child: Icon(
            isHide ? Icons.remove_red_eye : Icons.visibility_off,
            color: Colors.black87,
            size: 24,
          ),
        ),
      ),
      verticalSpace(40),
    ];
