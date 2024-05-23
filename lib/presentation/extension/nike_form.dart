// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_font.dart';

import '../misc/spacing.dart';

class NikeForm extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? withLabel;
  final int? minLines;
  final int? maxLines;
  final bool? readOnly;
  final Color? textColor;
  final Function(String value)? onChanged;
  const NikeForm({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.withLabel = true,
    this.minLines,
    this.maxLines,
    this.readOnly,
    this.textColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withLabel == true)
          Text(
            label,
            style: NikeFont.h4Regular().copyWith(color: Colors.black87),
          ),
        if (withLabel == true) verticalSpace(7),
        SizedBox(
          height: minLines != null && maxLines != null ? null : 60,
          child: TextField(
            controller: controller,
            readOnly: readOnly ?? false,
            obscureText: obscureText ?? false,
            onChanged: onChanged,
            style: NikeFont.h4Regular().copyWith(color: textColor),
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            keyboardType: keyboardType,
            minLines: minLines,
            maxLines: maxLines,
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintStyle: NikeFont.h4Regular(),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black87,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  )),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
