import 'dart:developer';

import 'package:quiosque/app/core/exceptions/repository_exception.dart';
import 'package:quiosque/app/core/rest_client/custom_dio.dart';
import 'package:quiosque/app/models/category_model.dart';
import 'package:dio/dio.dart';

import './categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CustomDio dio;

  CategoriesRepositoryImpl({required this.dio});

  @override
  Future<List<CategoryModel>> findAllCategories() async {
    try {
      final result = await dio.unauth().get('/categories');
      return result.data
          .map<CategoryModel>((p) => CategoryModel.fromMap(p))
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar categorias', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar categorias');
    }
  }
}
