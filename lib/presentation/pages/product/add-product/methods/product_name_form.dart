import 'package:flutter/material.dart';

import '../../../../extension/nike_form.dart';

Widget productNameForm({
  required TextEditingController productNameC,
}) =>
    Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: NikeForm(
        controller: productNameC,
        label: 'Product Name',
        hintText: 'Enter product name',
      ),
    );
