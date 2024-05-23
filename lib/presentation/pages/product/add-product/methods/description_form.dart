import 'package:flutter/material.dart';

import '../../../../extension/nike_form.dart';
import '../../../../misc/spacing.dart';

List<Widget> descriptionForm({
  required TextEditingController descC,
}) =>
    [
      verticalSpace(14),
      NikeForm(
        controller: descC,
        label: 'Description',
        hintText: 'Enter product description',
        minLines: 3,
        maxLines: 5,
      ),
    ];
