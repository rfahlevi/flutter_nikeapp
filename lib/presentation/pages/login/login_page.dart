import 'package:flutter/material.dart';
import 'package:flutter_nikeapp/presentation/blocs/auth/login_bloc/login_bloc.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_alert.dart';
import 'package:flutter_nikeapp/presentation/misc/spacing.dart';
import 'package:flutter_nikeapp/presentation/pages/login/methods/email_form.dart';
import 'package:flutter_nikeapp/presentation/pages/login/methods/login_button.dart';
import 'package:flutter_nikeapp/presentation/pages/login/methods/login_title.dart';
import 'package:flutter_nikeapp/presentation/pages/login/methods/nike_logo.dart';
import 'package:flutter_nikeapp/presentation/pages/login/methods/password_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nikeapp/presentation/pages/main/main_page.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  static const routerName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool isHide = true;

  bool togglePassword() {
    setState(() {
      isHide = !isHide;
    });

    return isHide;
  }

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (user) {
            NikeAlert.successful(context: context, content: 'Login Successfully!');
            context.goNamed(MainPage.routerName);
          },
          failed: (message) {
            NikeAlert.error(context: context, content: message);
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                verticalSpace(MediaQuery.of(context).size.height / 7),
                ...logo(context),
                ...loginTitle(),
                ...emailForm(emailC),
                ...passwordForm(
                  passwordC: passwordC,
                  isHide: isHide,
                  togglePassword: togglePassword,
                ),
                loginButton(
                  onPressed: () => context.read<LoginBloc>().add(
                        LoginEvent.doLogin(
                          email: emailC.text,
                          password: passwordC.text,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
