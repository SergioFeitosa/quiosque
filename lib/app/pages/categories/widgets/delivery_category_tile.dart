import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiosque/app/core/dto/order_product_dto.dart';
import 'package:quiosque/app/core/ui/styles/text_styles.dart';
import 'package:quiosque/app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:quiosque/app/pages/home/home_controller.dart';

class DeliveryCategoryTile extends StatelessWidget {
  final CategoryModel category;
  final List<OrderProductDto>? bag;
  final String estabelecimento;
  final String local;

  const DeliveryCategoryTile({
    super.key,
    required this.category,
    required this.bag,
    required this.estabelecimento,
    required this.local,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProductResult =
            await Navigator.of(context).pushNamed('/category', arguments: {
          'category': category,
          'bag': controller.state.shoppingBag,
          'estabelecimento': estabelecimento,
          'local': local,
        });
        if (orderProductResult != null) {
          controller.addOrUpdateBag(orderProductResult as OrderProductDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: category.image,
              width: 200,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              category.name,
              style: context.textStyles.textBold.copyWith(fontSize: 14),
            ),
            Text(
              category.description,
              style: context.textStyles.textMedium.copyWith(fontSize: 10),
            ),
            const Divider(
              color: Colors.black38,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
