import 'package:quiosque/app/core/ui/helpers/size_extensions.dart';
import 'package:quiosque/app/core/ui/styles/text_styles.dart';
import 'package:quiosque/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.percentHeight(.20),
              ),
              Image.asset('assets/images/logo_rounded.png'),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Pedido realizado com sucesso, em breve voce receberá a confirmação do seu pedido',
                  textAlign: TextAlign.center,
                  style:
                      context.textStyles.textExtraBold.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              DeliveryButton(
                width: context.percentWidth(.50),
                onPressed: () {
                  Navigator.pop(context);
                },
                label: 'FECHAR',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
