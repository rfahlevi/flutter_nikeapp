import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/presentation/blocs/auth/logout_bloc/logout_bloc.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_alert.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_loading.dart';
import 'package:flutter_nikeapp/presentation/pages/login/login_page.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  static const routerName = '/main';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: (hasLogout) {
                if (hasLogout) {
                  NikeAlert.successful(context: context, content: 'Logout Successfully!');
                  context.goNamed(LoginPage.routerName);
                } else {
                  NikeAlert.error(context: context, content: 'Logout Failed!');
                }
              },
              failed: (message) {
                NikeAlert.error(context: context, content: message);
              },
            );
          },
          builder: (context, state) {
            return BlocBuilder<LogoutBloc, LogoutState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => ElevatedButton(
                    onPressed: () => context.read<LogoutBloc>().add(const LogoutEvent.doLogout()),
                    child: const Text('Logout'),
                  ),
                  loading: () => ElevatedButton(
                    onPressed: () {},
                    child: NikeLoading.buttonCircular(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
