import 'package:quiosque/app/models/product_model.dart';

abstract interface class ProductsRepository {
  Future<List<ProductModel>> findAllProducts();
}
