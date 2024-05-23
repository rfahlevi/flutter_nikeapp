// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/domain/entities/product.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_font.dart';

import '../../../../blocs/product-category/bloc/get_product_categories_bloc.dart';
import '../../../../misc/nike_dropdown.dart';

class SelectCategories extends StatefulWidget {
  final Function(Category? category)? onChanged;
  const SelectCategories({
    super.key,
    this.onChanged,
  });

  @override
  State<SelectCategories> createState() => _SelectCategoriesState();
}

class _SelectCategoriesState extends State<SelectCategories> {
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: BlocBuilder<GetProductCategoriesBloc, GetProductCategoriesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => NikeDropdown(
              hint: 'Select Category',
              items: const [],
              onChanged: (value) {},
              label: 'Product Category',
            ),
            loading: () => NikeDropdown(
              hint: 'Fetch categories..',
              items: const [],
              onChanged: (value) {},
              label: 'Product Category',
            ),
            success: (categories) => NikeDropdown(
              hint: selectedCategory?.name ?? 'Select Category',
              hintStyle: selectedCategory != null ? NikeFont.h4Regular().copyWith(color: Colors.black87) : null,
              items: categories
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = categories.where((element) => element.id == value).firstOrNull;
                  widget.onChanged!(categories.where((element) => element.id == value).firstOrNull);
                });
              },
              label: 'Product Category',
            ),
          );
        },
      ),
    );
  }
}
