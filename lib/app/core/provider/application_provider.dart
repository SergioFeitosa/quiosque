import 'package:quiosque/app/core/rest_client/custom_dio.dart';
import 'package:quiosque/app/repositories/auth/auth_repository.dart';
import 'package:quiosque/app/repositories/auth/auth_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationProvider extends StatelessWidget {
  final Widget child;
  const ApplicationProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CustomDio(),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(dio: context.read()),
        ),
      ],
      child: child,
    );
  }
}
