// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quiosque/app/core/dto/order_product_dto.dart';

class OrderDto {
  List<OrderProductDto> products;
  String address;
  String document;
  int paymentTypeId;

  OrderDto({
    required this.products,
    required this.address,
    required this.document,
    required this.paymentTypeId,
  });
}
