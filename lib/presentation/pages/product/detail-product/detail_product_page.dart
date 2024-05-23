// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_nikeapp/domain/entities/product.dart' as p;
import 'package:flutter_nikeapp/helper/rupiah_formatter.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_font.dart';
import 'package:flutter_nikeapp/presentation/misc/spacing.dart';

class DetailProductPage extends StatelessWidget {
  static const routerName = 'detail-product-page';
  final p.Product product;
  const DetailProductPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        title: Text(
          'Product Detail',
          style: NikeFont.h3Medium(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 2,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                    ),
                    items: product.image.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  i.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ));
                        },
                      );
                    }).toList(),
                  ),
                ),
                horizontalSpaces(24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: NikeFont.h2SemiBold(),
                    ),
                    Text(
                      product.category.name,
                      style: NikeFont.h4Regular(),
                    ),
                    verticalSpace(14),
                    Text(
                      rupiahFormatter(product.price.toString()),
                      style: NikeFont.h3SemiBold().copyWith(
                        color: Colors.red,
                      ),
                    ),
                    verticalSpace(24),
                    Text(
                      'Colors :',
                      style: NikeFont.h5Regular(),
                    ),
                    verticalSpace(4),
                    Row(
                      children: List.generate(product.color.length, (index) {
                        String hexColor = '0XFF${product.color[index].hexCode}';

                        return Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 7),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(int.parse(hexColor)),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }),
                    ),
                    verticalSpace(24),
                    Text(
                      'Size :',
                      style: NikeFont.h5Regular(),
                    ),
                    verticalSpace(4),
                    Row(
                      children: List.generate(product.size.length, (index) {
                        return Container(
                          width: 60,
                          height: 39,
                          margin: const EdgeInsets.only(right: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            product.size[index].value,
                            style: NikeFont.h4Medium(),
                          ),
                        );
                      }),
                    ),
                    verticalSpace(24),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Add to Bag'),
                      ),
                    ),
                    verticalSpace(7),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          side: const BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        child: const Text('Add to Wishlist'),
                      ),
                    )
                  ],
                )
              ],
            ),
            verticalSpace(24),
            Text(
              'Product Description',
              style: NikeFont.h4Regular(),
            ),
            const Divider(color: Colors.black12),
            Text(
              product.name,
              style: NikeFont.h2SemiBold(),
            ),
            Text(
              product.category.name,
              style: NikeFont.h4Regular(),
            ),
            verticalSpace(14),
            Text(
              product.description,
              style: NikeFont.h4Regular(),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
