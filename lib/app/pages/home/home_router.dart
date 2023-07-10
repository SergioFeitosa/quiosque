import 'package:quiosque/app/pages/home/home_controller.dart';
import 'package:quiosque/app/pages/home/home_page.dart';
import 'package:quiosque/app/repositories/categories/categories_repository.dart';
import 'package:quiosque/app/repositories/categories/categories_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<CategoriesRepository>(
            create: (context) => CategoriesRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider(
            create: (context) => HomeController(context.read()),
          )
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>;

          return HomePage(
            bag: args['bag'],
          );
        },
      );
}
