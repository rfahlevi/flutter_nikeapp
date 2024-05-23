import 'package:flutter/material.dart';

import '../../../../extension/nike_form.dart';

Widget priceForm({
  required TextEditingController priceC,
}) =>
    Flexible(
      flex: 1,
      child: NikeForm(
        controller: priceC,
        label: 'Price (IDR)',
        hintText: 'Enter product price',
        keyboardType: TextInputType.number,
      ),
    );
