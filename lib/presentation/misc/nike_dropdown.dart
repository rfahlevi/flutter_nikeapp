import 'package:flutter/material.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_font.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_loading.dart';

import 'spacing.dart';

class NikeDropdown extends StatelessWidget {
  final String hint;
  final List<DropdownMenuItem<Object?>> items;
  final Function(dynamic value) onChanged;
  final Widget? icon;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final bool? withLabel;
  final String label;
  final bool? isLoading;
  const NikeDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.icon,
    this.hintStyle,
    this.backgroundColor,
    this.margin,
    this.withLabel = true,
    required this.label,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withLabel == true)
          Text(
            label,
            style: NikeFont.h4Regular(),
          ),
        if (withLabel == true) verticalSpace(7),
        Container(
          margin: margin ?? const EdgeInsets.only(top: 4, bottom: 7),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey,
            ),
            color: backgroundColor,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              icon: icon,
              elevation: 1,
              value: null,
              menuMaxHeight: MediaQuery.of(context).size.height / 3,
              hint: isLoading == true
                  ? NikeLoading.dropdown(context)
                  : Text(
                      hint,
                      style: hintStyle ?? NikeFont.h4Regular(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
              borderRadius: BorderRadius.circular(12),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
