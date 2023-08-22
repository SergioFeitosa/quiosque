import 'package:flutter/material.dart';
import 'package:quiosque/app/core/global/global_context.dart';
import 'package:quiosque/app/core/provider/application_provider.dart';
import 'package:quiosque/app/core/ui/theme/theme_config.dart';
import 'package:quiosque/app/pages/auth/login/login_router.dart';
import 'package:quiosque/app/pages/auth/register/register_router.dart';
import 'package:quiosque/app/pages/category/category_router.dart';
import 'package:quiosque/app/pages/credit_card/quiosque_credit_card_page.dart';
import 'package:quiosque/app/pages/home/home_router.dart';
import 'package:quiosque/app/pages/order/order_completed_page.dart';
import 'package:quiosque/app/pages/order/widget/order_router.dart';
import 'package:quiosque/app/pages/products/product_detail_router.dart';
import 'package:quiosque/app/pages/splash/splash_page.dart';

class Quiosque extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();

  Quiosque({super.key}) {
    GlobalContext.i.navigatorkey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationProvider(
      child: MaterialApp(
        title: 'Delivery App',
        theme: ThemeConfig.theme,
        navigatorKey: _navKey,
        routes: {
          '/': (context) => const SplashPage(),
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/home': (context) => HomeRouter.page,
          '/order': (context) => OrderRouter.page,
          '/order/completed': (context) => const OrderCompletedPage(),
          '/productDetail': (context) => ProductDetailRouter.page,
          '/category': (context) => CategoryRouter.page,
          '/quiosqueCreditCard': (context) => const QuiosqueCreditCardPage(),
        },
      ),
    );
  }
}
