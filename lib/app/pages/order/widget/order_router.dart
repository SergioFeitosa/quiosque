import 'package:quiosque/app/pages/order/order_controller.dart';
import 'package:quiosque/app/pages/order/order_page.dart';
import 'package:quiosque/app/repositories/order/order_repository.dart';
import 'package:quiosque/app/repositories/order/order_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderRouter {
  OrderRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepository>(
            create: (context) => OrderRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider(
            create: (context) => OrderController(context.read()),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>;

          return OrderPage(
            estabelecimento: args['estabelecimento'],
            local: args['local'],
            bag: args['bag'],
          );
        },
      );
}
