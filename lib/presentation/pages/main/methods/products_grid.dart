import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/presentation/pages/product/detail-product/detail_product_page.dart';
import 'package:flutter_nikeapp/presentation/widgets/empty_data.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/product/get_products_bloc/get_products_bloc.dart';
import '../../../misc/nike_font.dart';
import '../../../misc/nike_loading.dart';
import '../../../misc/spacing.dart';
import '../../../widgets/product_card.dart';

List<Widget> productsGrid() => [
      Text(
        'All Products',
        style: NikeFont.h4SemiBold(),
      ),
      verticalSpace(7),
      BlocBuilder<GetProductsBloc, GetProductsState>(
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => NikeLoading.shimmer(context),
              failed: (message) => Text(message),
              success: (products, isNext) {
                if (products.isEmpty) {
                  return const EmptyData();
                } else {
                  return Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: products.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 0.8),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: products[index],
                            onTap: () => context.goNamed(
                              DetailProductPage.routerName,
                              extra: products[index],
                            ),
                          );
                        },
                      ),
                      if (isNext) NikeLoading.loadData(context),
                      if (!isNext) NikeLoading.noDataMore(context)
                    ],
                  );
                }
              });
        },
      ),
    ];
