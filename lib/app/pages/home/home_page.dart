import 'package:quiosque/app/core/dto/order_product_dto.dart';
import 'package:quiosque/app/core/qrcode/qr_view_example.dart';
import 'package:quiosque/app/core/ui/base_state/base_state.dart';
import 'package:quiosque/app/core/ui/widgets/delivery_appbar_soft.dart';
import 'package:quiosque/app/pages/categories/widgets/delivery_category_tile.dart';
import 'package:quiosque/app/pages/home/home_controller.dart';
import 'package:quiosque/app/pages/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiosque/app/pages/products/widgets/shopping_bag_home_widget.dart';

class HomePage extends StatefulWidget {
  final List<OrderProductDto> bag;
  final String estabelecimento;
  final String local;
  const HomePage({
    Key? key,
    required this.bag,
    required this.estabelecimento,
    required this.local,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    //SharedPreferences.getInstance().then((value) => value.clear());
    controller.loadCategories();
    if (widget.bag.isNotEmpty) {
      controller.updateBag(widget.bag);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.state.shoppingBag.isEmpty
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const QRViewExample(),
              ))
            : null;
        return false;
      },
      child: Scaffold(
        appBar: DeliveryAppbarSoft(),
        body: BlocConsumer<HomeController, HomeState>(
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
                    itemCount: controller.state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return DeliveryCategoryTile(
                        category: category,
                        bag: controller.state.shoppingBag,
                        estabelecimento: widget.estabelecimento,
                        local: widget.local,
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: controller.state.shoppingBag.isNotEmpty,
                  child: ShoppingBagHomeWidget(
                    bag: controller.state.shoppingBag,
                    estabelecimento: widget.estabelecimento,
                    local: widget.local,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
