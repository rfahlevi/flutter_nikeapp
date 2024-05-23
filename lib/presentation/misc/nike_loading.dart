import 'package:flutter/material.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_font.dart';
import 'package:shimmer/shimmer.dart';

import 'spacing.dart';

class NikeLoading {
  static buttonCircular() => ElevatedButton(
        onPressed: () {},
        child: const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );

  static dropdown(BuildContext context) => Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          horizontalSpaces(14),
          Text(
            'Loading..',
            style: NikeFont.h4Regular(),
          )
        ],
      );

  static textButtonCircular() => TextButton(
        onPressed: () {},
        child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.red,
            strokeWidth: 2,
          ),
        ),
      );

  static shimmer(BuildContext context) => Column(
        children: [
          Row(
            children: List.generate(
              4,
              (index) => Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: MediaQuery.of(context).size.height / 3.5,
                  margin: const EdgeInsets.only(right: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color: Colors.grey[300]!,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 7,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.2),
                          highlightColor: Colors.grey.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                            child: Container(
                              width: 20,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.2),
                          highlightColor: Colors.grey.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                            child: Container(
                              width: 20,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.2),
                          highlightColor: Colors.grey.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                            child: Container(
                              width: 20,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.2),
                          highlightColor: Colors.grey.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                            child: Container(
                              width: 20,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      );

  static Widget loadData(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black87,
                      strokeWidth: 2,
                    )),
                const SizedBox(width: 7),
                Text(
                  'Sedang memuat data..',
                  style: NikeFont.h5Regular().copyWith(color: Colors.black87),
                ),
              ],
            )
          ],
        ),
      );

  static Widget noDataMore(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Tidak ada data lagi',
            style: NikeFont.h5Regular().copyWith(color: Colors.grey),
          ),
        ]),
      );
}
