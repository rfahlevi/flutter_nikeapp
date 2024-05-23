// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../misc/nike_font.dart';
import '../../../../misc/spacing.dart';

class SizeVariant extends StatefulWidget {
  final Function(List? selectedSizeVariant)? onSelectedSizeVariant;
  const SizeVariant({
    super.key,
    this.onSelectedSizeVariant,
  });

  @override
  State<SizeVariant> createState() => _SizeVariantState();
}

class _SizeVariantState extends State<SizeVariant> {
  List sizeVariant = [
    {'value': '39'},
    {'value': '40'},
    {'value': '41'},
    {'value': '42'},
    {'value': '43'},
  ];

  List selectedSizeVariant = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size Variant',
          style: NikeFont.h4Regular(),
        ),
        verticalSpace(7),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: sizeVariant
              .map(
                (e) => Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 7),
                  child: CheckboxListTile.adaptive(
                    value: selectedSizeVariant.contains(e),
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
                          selectedSizeVariant.add(e);
                        } else {
                          selectedSizeVariant.remove(e);
                        }
                        widget.onSelectedSizeVariant!(selectedSizeVariant);
                      });
                    },
                    title: Text(
                      e['value'],
                      style: NikeFont.h4Medium(),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        verticalSpace(14),
      ],
    );
  }
}
