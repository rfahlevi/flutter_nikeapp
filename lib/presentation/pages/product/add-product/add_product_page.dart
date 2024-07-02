// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/domain/entities/product.dart' as category;
import 'package:flutter_nikeapp/helper/internet_check.dart';
import 'package:flutter_nikeapp/presentation/blocs/product-category/bloc/get_product_categories_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/product/add_product_bloc/add_product_bloc.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_alert.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_loading.dart';
import 'package:flutter_nikeapp/presentation/misc/spacing.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/methods/color_variant.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/methods/description_form.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/methods/is_featured.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/methods/price_form.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/methods/product_name_form.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/methods/release_date.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/methods/select_categories.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/methods/size_variant.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/methods/upload_images.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/product/get_products_bloc/get_products_bloc.dart';
import '../../../misc/nike_font.dart';

class AddProductPage extends StatefulWidget {
  static const routerName = 'add-product';
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController productNameC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController releaseDateC = TextEditingController();
  category.Category? selectedProductCategory;

  int? selectedFeatured = 0;

  List<String> selectedImages = [];
  List selectedSize = [];
  List selectedColor = [];

  @override
  void initState() {
    context.read<GetProductCategoriesBloc>().add(const GetProductCategoriesEvent.doGet());
    super.initState();
  }

  @override
  void dispose() {
    productNameC.dispose();
    priceC.dispose();
    descC.dispose();
    releaseDateC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (message) async {
            NikeAlert.successful(context: context, content: message);
            bool hasInternet = await InternetChecker.hasInternetConnection();

            if (hasInternet) {
              context.read<GetProductsBloc>().add(const GetProductsEvent.getFirst(productSearch: ''));
            }
            context.pop();
          },
          failed: (message) {
            NikeAlert.error(context: context, content: message);
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          title: Text(
            'Add Product',
            style: NikeFont.h3Medium(),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: BlocBuilder<AddProductBloc, AddProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => ElevatedButton(
                  onPressed: () {
                    if (selectedImages.isEmpty) {
                      NikeAlert.notice(context: context, content: 'Please select at least one image');
                    } else if (productNameC.text.isEmpty) {
                      NikeAlert.notice(context: context, content: 'Please enter product name');
                    } else if (selectedProductCategory == null) {
                      NikeAlert.notice(context: context, content: 'Please select product category');
                    } else if (descC.text.isEmpty) {
                      NikeAlert.notice(context: context, content: 'Please enter description');
                    } else if (priceC.text.isEmpty) {
                      NikeAlert.notice(context: context, content: 'Please enter price');
                    } else if (releaseDateC.text.isEmpty) {
                      NikeAlert.notice(context: context, content: 'Please enter release date');
                    } else if (selectedSize.isEmpty) {
                      NikeAlert.notice(context: context, content: 'Please select at least one size');
                    } else if (selectedColor.isEmpty) {
                      NikeAlert.notice(context: context, content: 'Please select at least one color');
                    } else {
                      context.read<AddProductBloc>().add(
                            AddProductEvent.doAdd(
                              productCategoryId: selectedProductCategory!.id,
                              name: productNameC.text,
                              slug: '',
                              size: selectedSize,
                              color: selectedColor,
                              images: selectedImages,
                              releaseDate: releaseDateC.text,
                              isAvailable: selectedFeatured!,
                              price: int.parse(priceC.text),
                              description: descC.text,
                              isSyncData: false,
                            ),
                          );
                    }
                  },
                  child: const Text('Submit'),
                ),
                loading: () => ElevatedButton(
                  onPressed: () {},
                  child: NikeLoading.buttonCircular(),
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ListView(
            children: [
              UploadImages(
                onSelected: (selectedProductImages) {
                  selectedImages = selectedProductImages ?? [];
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  productNameForm(productNameC: productNameC),
                  horizontalSpaces(24),
                  SelectCategories(
                    onChanged: (category) {
                      selectedProductCategory = category;
                    },
                  ),
                ],
              ),
              ...descriptionForm(descC: descC),
              verticalSpace(14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  priceForm(priceC: priceC),
                  horizontalSpaces(24),
                  ReleaseDate(
                    releaseDateC: releaseDateC,
                    onSelected: (date) {
                      if (date != null) {
                        releaseDateC.text = date;
                      }
                    },
                  )
                ],
              ),
              IsFeatured(
                onChanged: (value) {
                  selectedFeatured = value;
                },
              ),
              SizeVariant(
                onSelectedSizeVariant: (selectedSizeVariant) {
                  selectedSize = selectedSizeVariant ?? [];
                },
              ),
              ColorVariant(
                onSelectedColorVariant: (selectedColorVariant) {
                  selectedColor = selectedColorVariant ?? [];
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
