import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:quiosque/app/core/dto/order_product_dto.dart';

import 'package:quiosque/app/pages/home/home_state.dart';
import 'package:quiosque/app/repositories/categories/categories_repository.dart';

class HomeController extends Cubit<HomeState> {
  final CategoriesRepository _categoriesRepository;

  HomeController(this._categoriesRepository) : super(const HomeState.initial());

  Future<void> loadCategories() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final categories = await _categoriesRepository.findAllCategories();
      emit(state.copyWith(
          status: HomeStateStatus.loaded, categories: categories));
    } catch (e, s) {
      log('Erro ao buscar categorias', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: HomeStateStatus.error,
            errorMessage: 'Erro ao buscar categorias'),
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
