import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiosque/app/core/dto/order_product_dto.dart';
import 'package:quiosque/app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:quiosque/app/pages/home/home_controller.dart';

class DeliveryCategoryTile extends StatelessWidget {
  final CategoryModel category;
  final OrderProductDto? orderProduct;

  const DeliveryCategoryTile({
    super.key,
    required this.category,
    required this.orderProduct,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProductResult =
            await Navigator.of(context).pushNamed('/category', arguments: {
          'category': category,
          'order': orderProduct,
        });
        if (orderProductResult != null) {
          controller.addOrUpdateBag(orderProductResult as OrderProductDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: category.image,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                Text(category.name),
                Text(category.description)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
