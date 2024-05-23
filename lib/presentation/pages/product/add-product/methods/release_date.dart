// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../extension/nike_form.dart';

class ReleaseDate extends StatefulWidget {
  final TextEditingController releaseDateC;
  final Function(String? date)? onSelected;
  const ReleaseDate({
    super.key,
    required this.releaseDateC,
    this.onSelected,
  });

  @override
  State<ReleaseDate> createState() => _ReleaseDateState();
}

class _ReleaseDateState extends State<ReleaseDate> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: NikeForm(
        controller: widget.releaseDateC,
        readOnly: true,
        label: 'Release Date',
        hintText: 'Select Date',
        suffixIcon: IconButton(
          onPressed: () async {
            DateTime? datePicker = await showDatePicker(
              context: context,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (datePicker != null) {
              setState(() {
                widget.onSelected!(datePicker.toString().substring(0, 10));
                widget.releaseDateC.text = datePicker.toString().substring(0, 10);
              });
            }
          },
          icon: const Icon(
            Icons.calendar_month_rounded,
            color: Colors.black87,
            size: 26,
          ),
        ),
      ),
    );
  }
}
