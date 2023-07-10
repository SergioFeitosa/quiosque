import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiosque/app/core/dto/order_product_dto.dart';

import 'package:quiosque/app/core/ui/base_state/base_state.dart';

import 'package:quiosque/app/models/category_model.dart';
import 'package:quiosque/app/pages/category/category_controller.dart';
import 'package:quiosque/app/pages/category/category_state.dart';
import 'package:quiosque/app/pages/products/widgets/delivery_product_tile.dart';
import 'package:quiosque/app/pages/products/widgets/shopping_bag_widget.dart';

class CategoryPage extends StatefulWidget {
  final CategoryModel category;
  final List<OrderProductDto>? bag;
  const CategoryPage({Key? key, required this.category, required this.bag})
      : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends BaseState<CategoryPage, CategoryController> {
  @override
  void onReady() {
    //SharedPreferences.getInstance().then((value) => value.clear());
    controller.loadProducts();
    //final List<OrderProductDto>? shoppingBag = controller.getBag;
    controller.updateBag(widget.bag!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.yellow),
            onPressed: () async {
              await Navigator.of(context).pushNamed('/home', arguments: {
                'bag': controller.getBag,
              });
            },
          ),
          title: const Text('Category Page'),
          centerTitle: true,
        ),
        body: BlocConsumer<CategoryController, CategoryState>(
          listener: (context, state) {
            state.status.matchAny(
                any: () => hideLoader(),
                loading: () => showLoader(),
                error: () {
                  hideLoader();
                  showError(state.errorMessage ?? 'Erro de acesso ao produto');
                });
          },
          buildWhen: (previous, current) => current.status.matchAny(
            any: () => false,
            initial: () => true,
            loaded: () => true,
          ),
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.products
                        .where((product) =>
                            product.categoryId == widget.category.id)
                        .length,
                    itemBuilder: (context, index) {
                      final products = state.products
                          .where((product) =>
                              product.categoryId == widget.category.id)
                          .toList();

                      final product = products[index];

                      final orders = state.shoppingBag;

                      return DeliveryProductTile(
                        product: product,
                        orderProduct: orders.isNotEmpty ? orders.first : null,
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: state.shoppingBag.isNotEmpty,
                  child: ShoppingBagWidget(bag: state.shoppingBag),
                )
              ],
            );
          },
        ));
  }
}