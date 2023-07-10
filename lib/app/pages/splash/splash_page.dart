import 'package:quiosque/app/core/dto/order_product_dto.dart';
import 'package:quiosque/app/core/ui/helpers/size_extensions.dart';
import 'package:quiosque/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OrderProductDto> bag = [];
    return Scaffold(
      body: ColoredBox(
        color: const Color(0XFF140E0E),
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: context.percentHeight(.2),
                  ),
                  Image.asset(
                    'assets/images/lanche-chapeu-preto.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  DeliveryButton(
                    width: context.percentWidth(.6),
                    height: 35,
                    label: 'ACESSAR',
                    onPressed: () {
                      //  Navigator.of(context).popAndPushNamed('/home');
                      Navigator.of(context)
                          .pushNamed('/home', arguments: {'bag': bag});
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
