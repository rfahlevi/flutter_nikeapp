// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../misc/nike_font.dart';
import '../../../../misc/spacing.dart';

class IsFeatured extends StatefulWidget {
  final Function(int? value)? onChanged;
  const IsFeatured({
    super.key,
    required this.onChanged,
  });

  @override
  State<IsFeatured> createState() => _IsFeaturedState();
}

class _IsFeaturedState extends State<IsFeatured> {
  int? selectedFeatured = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(14),
        Text(
          'Is Featured?',
          style: NikeFont.h4Regular(),
        ),
        verticalSpace(7),
        Row(
          children: List.generate(
            2,
            (index) => SizedBox(
              width: 100,
              child: Container(
                margin: index == 0 ? const EdgeInsets.only(right: 7) : null,
                child: RadioListTile.adaptive(
                  value: index,
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 7, right: 14),
                  activeColor: Colors.white,
                  selected: selectedFeatured == index ? true : false,
                  selectedTileColor: Colors.red,
                  title: Text(
                    index == 0 ? 'No' : 'Yes',
                    style: NikeFont.h4Medium(),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: selectedFeatured == index ? Colors.transparent : Colors.grey,
                    ),
                  ),
                  groupValue: selectedFeatured,
                  onChanged: (value) {
                    setState(() {
                      widget.onChanged!(value);
                      selectedFeatured = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        verticalSpace(14),
      ],
    );
  }
}
