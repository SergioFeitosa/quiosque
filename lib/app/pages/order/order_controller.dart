import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:quiosque/app/core/dto/order_dto.dart';
import 'package:quiosque/app/core/dto/order_product_dto.dart';
import 'package:quiosque/app/pages/order/order_state.dart';
import 'package:quiosque/app/repositories/order/order_repository.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;
  OrderController(this._orderRepository) : super(const OrderState.initial());

  Future<void> load(List<OrderProductDto> products) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));

      final paymentTypes = await _orderRepository.getAllPaymentsTypes();

      emit(
        state.copyWith(
          orderProducts: products,
          status: OrderStatus.loaded,
          paymentTypes: paymentTypes,
        ),
      );
    } catch (e, s) {
      log('Erro ao carregar página', error: e, stackTrace: s);
      emit(state.copyWith(
          status: OrderStatus.error, errorMessage: 'Erro ao carregar página'));
    }
  }

  void incrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];

    orders[index] = order.copyWith(amount: order.amount + 1);

    emit(
        state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder));
  }

  void decrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];

    if (order.amount == 1) {
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(
          OrderConfirmDeleteProductState(
              orderProduct: order,
              index: index,
              status: OrderStatus.confirmRemoveProduct,
              orderProducts: state.orderProducts,
              paymentTypes: state.paymentTypes,
              errorMessage: state.errorMessage),
        );

        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: order.amount - 1);
    }
    if (orders.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyBag));
      return;
    }

    emit(
        state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder));
  }

  void addOrUpdateOrder(OrderProductDto orderProduct) {
    final shoppingOrder = [...state.orderProducts];

    final orderIndex = shoppingOrder
        .indexWhere((orderP) => orderP.product.id == orderProduct.product.id);

    if (orderIndex > -1) {
      if (orderProduct.amount == 0) {
        shoppingOrder.removeAt(orderIndex);
      } else {
        shoppingOrder[orderIndex] = orderProduct;
      }
    } else {
      shoppingOrder.add(orderProduct);
    }

    emit(state.copyWith(orderProducts: shoppingOrder));
  }

  void updateOrder(List<OrderProductDto> updateOrder) {
    emit(state.copyWith(orderProducts: updateOrder));
  }

  void cancelDeleteProcess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  void emptyBag() {
    emit(state.copyWith(status: OrderStatus.emptyBag));
  }

  void saveOrder({
    required String address,
    required String document,
    required int paymentTypeId,
  }) async {
    emit(state.copyWith(status: OrderStatus.loading));
    await _orderRepository.saveOrder(
      OrderDto(
        products: state.orderProducts,
        address: address,
        document: document,
        paymentTypeId: paymentTypeId,
      ),
    );
    emit(state.copyWith(status: OrderStatus.success));
  }
}
