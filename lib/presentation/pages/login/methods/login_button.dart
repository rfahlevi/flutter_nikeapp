import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_loading.dart';

import '../../../blocs/auth/login_bloc/login_bloc.dart';

Widget loginButton({required VoidCallback onPressed}) => BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => ElevatedButton(
            onPressed: onPressed,
            child: const Text('Login'),
          ),
          loading: () => ElevatedButton(
            onPressed: () {},
            child: NikeLoading.buttonCircular(),
          ),
        );
      },
    );
