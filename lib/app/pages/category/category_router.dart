import 'package:quiosque/app/pages/category/category_controller.dart';
import 'package:quiosque/app/pages/category/category_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiosque/app/repositories/products/products_repository.dart';
import 'package:quiosque/app/repositories/products/products_repository_impl.dart';

class CategoryRouter {
  CategoryRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductsRepository>(
            create: (context) => ProductsRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider(
            create: (context) => CategoryController(context.read()),
          )
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return CategoryPage(
            category: args['category'],
            order: args['order'],
          );
        },
      );
}
