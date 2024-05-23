// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../misc/nike_font.dart';
import '../../../../misc/spacing.dart';

class ColorVariant extends StatefulWidget {
  final Function(List? selectedColorVariant)? onSelectedColorVariant;
  const ColorVariant({
    super.key,
    this.onSelectedColorVariant,
  });

  @override
  State<ColorVariant> createState() => _ColorVariantState();
}

class _ColorVariantState extends State<ColorVariant> {
  List colorVariant = [
    {'name': 'Black', 'hex_code': '000000'},
    {'name': 'White', 'hex_code': 'FFFFFF'},
    {'name': 'Red', 'hex_code': 'FF0000'},
    {'name': 'Blue', 'hex_code': '0000FF'},
  ];

  List selectedColorVariant = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Variant',
          style: NikeFont.h4Regular(),
        ),
        verticalSpace(7),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: colorVariant.map((e) {
            String hexCodeSubstring = '0XFF${e['hex_code']}';
            int hexCode = int.parse(hexCodeSubstring);
            return Container(
              width: 140,
              margin: const EdgeInsets.only(right: 7),
              child: CheckboxListTile.adaptive(
                value: selectedColorVariant.contains(e),
                dense: true,
                enabled: true,
                activeColor: Colors.red,
                contentPadding: const EdgeInsets.only(left: 14),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.grey),
                ),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedColorVariant.add(e);
                    } else {
                      selectedColorVariant.remove(e);
                    }
                    widget.onSelectedColorVariant!(selectedColorVariant);
                  });
                },
                title: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]!),
                        shape: BoxShape.circle,
                        color: Color(hexCode),
                      ),
                    ),
                    Text(
                      e['name'],
                      style: NikeFont.h4Medium(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
