import 'package:quiosque/app/pages/auth/register/register_controller.dart';
import 'package:quiosque/app/pages/auth/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RegisterRouter {
  RegisterRouter._();

  static Widget get page => MultiBlocProvider(
        providers: [
          Provider(
            create: ((context) => RegisterController(
                  context.read(),
                )),
          ),
        ],
        child: const RegisterPage(),
      );
}
