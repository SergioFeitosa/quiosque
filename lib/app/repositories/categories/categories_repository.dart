import 'package:quiosque/app/models/category_model.dart';

abstract interface class CategoriesRepository {
  Future<List<CategoryModel>> findAllCategories();
}
