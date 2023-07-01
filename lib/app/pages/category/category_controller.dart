import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:quiosque/app/core/dto/order_product_dto.dart';
import 'package:quiosque/app/pages/category/category_state.dart';
import 'package:quiosque/app/repositories/products/products_repository.dart';

class CategoryController extends Cubit<CategoryState> {
  final ProductsRepository _productsRepository;

  CategoryController(this._productsRepository)
      : super(const CategoryState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: CategoryStateStatus.loading));
    try {
      final products = await _productsRepository.findAllProducts();

      emit(state.copyWith(
          status: CategoryStateStatus.loaded, products: products));
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: CategoryStateStatus.error,
            errorMessage: 'Erro ao buscar produtos'),
      );
    }
  }

  void addOrUpdateBag(OrderProductDto orderProduct) {
    final shoppingBag = [...state.shoppingBag];

    final orderIndex = shoppingBag
        .indexWhere((orderP) => orderP.product == orderProduct.product);

    if (orderIndex > -1) {
      if (orderProduct.amount == 0) {
        shoppingBag.removeAt(orderIndex);
      } else {
        shoppingBag[orderIndex] = orderProduct;
      }
    } else {
      shoppingBag.add(orderProduct);
    }

    emit(state.copyWith(shoppingBag: shoppingBag));
  }

  void updateBag(List<OrderProductDto> updateBag) {
    emit(state.copyWith(shoppingBag: updateBag));
  }
}
