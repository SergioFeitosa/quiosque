import 'package:quiosque/app/core/dto/order_dto.dart';
import 'package:quiosque/app/models/payment_type_model.dart';

abstract interface class OrderRepository {
  Future<List<PaymentTypeModel>> getAllPaymentsTypes();

  Future<void> saveOrder(OrderDto order);
}
