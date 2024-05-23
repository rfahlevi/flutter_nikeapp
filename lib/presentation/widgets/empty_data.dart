import 'package:flutter/material.dart';

import '../misc/nike_font.dart';
import '../misc/spacing.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/img/img_empty.png',
              width: 100,
              fit: BoxFit.cover,
            ),
            verticalSpace(14),
            Text(
              'Oopss, No products found...',
              style: NikeFont.h4Medium(),
            ),
          ],
        ),
      ),
    );
  }
}
