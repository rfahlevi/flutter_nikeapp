import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/product/get_products_bloc/get_products_bloc.dart';
import '../../../extension/search_form.dart';
import '../../../misc/spacing.dart';

List<Widget> searchProducts({
  required BuildContext context,
  required TextEditingController searchC,
}) =>
    [
      SearchForm(
        searchC: searchC,
        hintText: 'Type product name..',
        label: 'Search Product',
        debouncerFunc: () =>
            context.read<GetProductsBloc>().add(GetProductsEvent.getFirst(productSearch: searchC.text)),
        suffixOnPressed: () =>
            context.read<GetProductsBloc>().add(GetProductsEvent.getFirst(productSearch: searchC.text)),
        onSubmitted: (value) => context.read<GetProductsBloc>().add(GetProductsEvent.getFirst(productSearch: value)),
      ),
      verticalSpace(14),
    ];
