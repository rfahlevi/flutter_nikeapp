// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_nikeapp/domain/entities/product.dart' as p;
import 'package:flutter_nikeapp/presentation/pages/product/detail-product/detail_product_page.dart';
import 'package:go_router/go_router.dart';

import '../../helper/rupiah_formatter.dart';
import '../misc/nike_font.dart';
import '../misc/spacing.dart';

class ProductCard extends StatelessWidget {
  final p.Product product;
  final VoidCallback onTap;
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(
        DetailProductPage.routerName,
        extra: product,
      ),
      splashColor: Colors.black87.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(7),
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                product.image[0].imageUrl,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 6,
                width: double.infinity,
              ),
            ),
            verticalSpace(7),
            Text(
              product.name,
              style: NikeFont.h4SemiBold(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              product.category.name,
              style: NikeFont.h5Regular(),
            ),
            Text(
              product.description,
              style: NikeFont.h6Regular(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            verticalSpace(7),
            Text(
              rupiahFormatter(
                product.price.toString(),
              ),
              style: NikeFont.h4SemiBold().copyWith(
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
