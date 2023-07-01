// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:quiosque/app/core/dto/order_product_dto.dart';
import 'package:quiosque/app/models/product_model.dart';

part 'category_state.g.dart';

@match
enum CategoryStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class CategoryState extends Equatable {
  final CategoryStateStatus status;
  final List<ProductModel> products;
  final String? errorMessage;
  final List<OrderProductDto> shoppingBag;
  const CategoryState({
    required this.status,
    required this.products,
    required this.shoppingBag,
    this.errorMessage,
  });

  const CategoryState.initial()
      : status = CategoryStateStatus.initial,
        products = const [],
        shoppingBag = const [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, products, errorMessage, shoppingBag];

  CategoryState copyWith({
    CategoryStateStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
    List<OrderProductDto>? shoppingBag,
  }) {
    return CategoryState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      shoppingBag: shoppingBag ?? this.shoppingBag,
    );
  }
}
