import 'package:quiosque/app/core/dto/order_product_dto.dart';
import 'package:quiosque/app/core/extensions/formatter_extensions.dart';
import 'package:quiosque/app/core/ui/base_state/base_state.dart';
import 'package:quiosque/app/core/ui/helpers/size_extensions.dart';
import 'package:quiosque/app/core/ui/styles/text_styles.dart';
import 'package:quiosque/app/core/ui/widgets/delivery_button.dart';
import 'package:quiosque/app/models/payment_type_model.dart';
import 'package:quiosque/app/pages/order/order_controller.dart';
import 'package:quiosque/app/pages/order/order_state.dart';
import 'package:quiosque/app/pages/order/widget/order_product_tile.dart';
import 'package:quiosque/app/pages/order/widget/payment_types_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
  final String estabelecimento;
  final String local;
  final List<OrderProductDto> bag;

  const OrderPage(
      {super.key,
      required this.estabelecimento,
      required this.local,
      required this.bag});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final formKey = GlobalKey<FormState>();
  final addressEC = TextEditingController();
  final documentEC = TextEditingController();
  int? paymentTypeId;
  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onReady() {
    final products = widget.bag;
    controller.load(products);
  }

  void _showConfirmProductDialog(OrderConfirmDeleteProductState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
              'Deseja excluir o produto ${state.orderProduct.product.name}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.cancelDeleteProcess();
              },
              child: Text(
                'Cancelar',
                style: context.textStyles.textExtraBold
                    .copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.decrementProduct(state.index);
              },
              child: Text(
                'Confirmar',
                style: context.textStyles.textExtraBold
                    .copyWith(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            error: () => {
                  hideLoader(),
                  showError(state.errorMessage ?? 'Erro não informado'),
                },
            confirmRemoveProduct: () {
              hideLoader();
              if (state is OrderConfirmDeleteProductState) {
                _showConfirmProductDialog(state);
              }
            },
            updateOrder: () {
              hideLoader();
              controller.addOrUpdateOrder(state.orderProducts.first);
            },
            emptyBag: () {
              showInfo('Sua sacola está vazia, Selecione um produto ou mais');
              Navigator.pop(context, <OrderProductDto>[]);
            },
            success: () {
              hideLoader();
              Navigator.of(context).popAndPushNamed('/order/completed',
                  result: <OrderProductDto>[]);
            });
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.orderProducts);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () async {
                await Navigator.of(context).pushNamed('/home', arguments: {
                  'bag': controller.state.orderProducts,
                  'estabelecimento': widget.estabelecimento,
                  'local': widget.local,
                });
              },
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  await Navigator.of(context).pushNamed('/home', arguments: {
                    'bag': controller.state.orderProducts,
                    'estabelecimento': widget.estabelecimento,
                    'local': widget.local,
                  });
                },
                child: Image.asset(
                  "assets/images/chapeudecouro02.png",
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            centerTitle: true,
          ),
          body: Form(
            key: formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Row(children: [
                      Text(
                        'Carrinho',
                        style: context.textStyles.textTitle,
                      ),
                      IconButton(
                        onPressed: () {
                          controller.emptyBag();
                        },
                        icon: Image.asset('assets/images/trashRegular.png'),
                      ),
                    ]),
                  ),
                ),
                BlocSelector<OrderController, OrderState,
                    List<OrderProductDto>>(
                  selector: (state) => state.orderProducts,
                  builder: (context, orderProducts) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: orderProducts.length,
                        (context, index) {
                          final orderProduct = orderProducts[index];
                          return Column(
                            children: [
                              OrderProductTile(
                                index: index,
                                orderProduct: orderProduct,
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total do Pedido',
                              style: context.textStyles.textExtraBold.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalOrder,
                              builder: (context, totalOrder) {
                                return Text(
                                  totalOrder.currencyPTBR,
                                  style:
                                      context.textStyles.textExtraBold.copyWith(
                                    fontSize: 20,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Estabelecimento: ${widget.estabelecimento} ',
                              style: context.textStyles.textRegular.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Local: ${widget.local}',
                              style: context.textStyles.textRegular.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocSelector<OrderController, OrderState,
                          List<PaymentTypeModel>>(
                        selector: (state) => state.paymentTypes,
                        builder: (context, paymentTypes) {
                          return ValueListenableBuilder(
                            valueListenable: paymentTypeValid,
                            builder: (_, paymentTypeValidValue, child) {
                              return PaymentTypesField(
                                paymentTypes: paymentTypes,
                                valueChanged: (value) {
                                  paymentTypeId = value;
                                },
                                valid: paymentTypeValidValue,
                                valueSelected: paymentTypeId.toString(),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Divider(
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: DeliveryButton(
                              width: context.percentWidth(.425),
                              height: 68,
                              onPressed: () async {
                                Navigator.of(context)
                                    .pop(controller.state.orderProducts);
                              },
                              label: 'Continuar comprando',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: DeliveryButton(
                              width: context.percentWidth(.425),
                              height: 68,
                              onPressed: () {
                                final valid =
                                    formKey.currentState?.validate() ?? false;
                                final paymentTypeSelected =
                                    paymentTypeId != null;
                                paymentTypeValid.value = paymentTypeSelected;
                                if (valid && paymentTypeSelected) {
                                  // controller.saveOrder(
                                  //     address: widget.estabelecimento,
                                  //     document: widget.local,
                                  //     paymentTypeId: paymentTypeId!);

                                  switch (paymentTypeId) {
                                    case 1:
                                      Navigator.of(context).pushNamed(
                                          '/quiosqueCreditCard',
                                          arguments: {
                                            'bag':
                                                controller.state.orderProducts,
                                            'estabelecimento':
                                                widget.estabelecimento,
                                            'local': widget.local,
                                          });
                                      break;
                                    case 2:
                                      Navigator.of(context).pushNamed(
                                          '/quiosqueCreditCard',
                                          arguments: {
                                            'bag':
                                                controller.state.orderProducts,
                                            'estabelecimento':
                                                widget.estabelecimento,
                                            'local': widget.local,
                                          });
                                      break;
                                    default:
                                  }

                                  if (paymentTypeId == 1) {}
                                }
                              },
                              label: 'FINALIZAR',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
