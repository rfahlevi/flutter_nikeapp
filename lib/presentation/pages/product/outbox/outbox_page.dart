import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/helper/sqflite_helper.dart';
import 'package:flutter_nikeapp/presentation/blocs/product/get_products_bloc/get_products_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/sync_data_bloc/sync_data_bloc.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_font.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_loading.dart';
import 'package:flutter_nikeapp/presentation/widgets/empty_data.dart';
import 'package:flutter_nikeapp/presentation/widgets/outbox_card.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../helper/product_table.dart';

class OutBoxPage extends StatefulWidget {
  static const routerName = 'outbox';
  const OutBoxPage({super.key});

  @override
  State<OutBoxPage> createState() => _OutBoxPageState();
}

class _OutBoxPageState extends State<OutBoxPage> {
  TextEditingController searchC = TextEditingController();

  Future<List<ProductTable>> getProductsFromLocal({String? search}) async {
    var products = await SqfliteHelper().getProducts(search: search);
    return products;
  }

  @override
  void dispose() {
    searchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SyncDataBloc, SyncDataState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loading: () => EasyLoading.show(status: 'Syncing data on progress..'),
          success: (message) {
            EasyLoading.showSuccess(message);
            context.read<GetProductsBloc>().add(const GetProductsEvent.getFirst(productSearch: ''));
            Future.delayed(Duration.zero, () {
              getProductsFromLocal();
              setState(() {});
            });
          },
          failed: (message) => EasyLoading.showError(message),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          title: Text(
            'Outbox',
            style: NikeFont.h3Medium(),
          ),
          actions: [
            // IconButton(
            //   onPressed: () async {
            //     await SqfliteHelper().deleteAllProducts();

            //     // print(await DirectoryPath().getPath());
            //   },
            //   icon: const Icon(
            //     Icons.remove_circle,
            //     size: 24,
            //     color: Colors.white,
            //   ),
            // ),
            IconButton(
              onPressed: () => context.read<SyncDataBloc>().add(const SyncDataEvent.doSync()),
              icon: const Icon(
                Icons.sync_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              FutureBuilder(
                future: getProductsFromLocal(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return NikeLoading.shimmer(context);
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const EmptyData();
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 0.8),
                      itemBuilder: (context, index) {
                        return OutboxCard(
                          product: snapshot.data![index],
                          onDelete: () {
                            EasyLoading.showSuccess('Product deleted successfully');
                            getProductsFromLocal();
                            setState(() {});
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
