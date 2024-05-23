import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_loading.dart';
import 'package:flutter_nikeapp/presentation/pages/product/add-product/add_product_page.dart';
import 'package:flutter_nikeapp/presentation/pages/product/outbox/outbox_page.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/auth/logout_bloc/logout_bloc.dart';
import '../../../misc/nike_font.dart';
import '../../../misc/spacing.dart';

List<Widget> header({
  required BuildContext context,
  required String? userName,
}) =>
    [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hai, ${userName ?? '....'}',
                style: NikeFont.h3Medium(),
              ),
              Text(
                'Welcome back to Nike App',
                style: NikeFont.h4Regular(),
              )
            ],
          ),
          const Spacer(),
          Container(
            width: 140,
            height: 34,
            margin: const EdgeInsets.only(right: 14),
            child: ElevatedButton(
              onPressed: () => context.goNamed(AddProductPage.routerName),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
              child: Text(
                'Add Product',
                style: NikeFont.h6Medium().copyWith(color: Colors.red),
              ),
            ),
          ),
          Container(
            width: 140,
            height: 34,
            margin: const EdgeInsets.only(right: 40),
            child: ElevatedButton(
              onPressed: () => context.goNamed(OutBoxPage.routerName),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Outbox',
                style: NikeFont.h6Medium().copyWith(color: Colors.white),
              ),
            ),
          ),
          BlocBuilder<LogoutBloc, LogoutState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return AlertDialog.adaptive(
                          title: const Text('Confirm Logout!'),
                          content: const Text('Are you sure want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.read<LogoutBloc>().add(const LogoutEvent.doLogout());
                                context.pop();
                              },
                              child: Text(
                                'Logout',
                                style: NikeFont.h5Medium().copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.pop(),
                              child: Text(
                                'Cancel',
                                style: NikeFont.h5Medium().copyWith(
                                  color: Colors.black87,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      horizontalSpaces(7),
                      Text(
                        'Logout',
                        style: NikeFont.h5Medium().copyWith(color: Colors.red),
                      )
                    ],
                  ),
                ),
                loading: () => IconButton(
                  onPressed: () {},
                  icon: NikeLoading.dropdown(context),
                ),
              );
            },
          ),
        ],
      ),
      verticalSpace(20),
    ];
