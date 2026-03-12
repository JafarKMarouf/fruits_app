import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/entities/product_entity.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/core/models/product_model.dart';
import 'package:fruits_app/core/services/database_service.dart';
import 'package:fruits_app/core/utils/backend_endpoints.dart';

import 'product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final DatabaseService databaseService;
  const ProductRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts() async {
    try {
      var products =
          await databaseService.getData(
                path: BackendEndpoints.bestSellingProducts,
                query: {
                  'orderBy': 'selling_count',
                  'descending': true,
                  'limit': 10,
                },
              )
              as List<Map<String, dynamic>>;
      var productEntityList = products
          .map((product) => ProductModel.fromJson(product).toEntity())
          .toList();
      return Right(productEntityList);
    } catch (e) {
      log(
        'Exception in ProductRepoImpl.getBestSellingProducts: ${e.toString()}',
      );
      return Left(ServerFailure('Failed to fetch best selling'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      var products =
          await databaseService.getData(path: BackendEndpoints.products)
              as List<Map<String, dynamic>>;
      var productEntityList = products
          .map((product) => ProductModel.fromJson(product).toEntity())
          .toList();
      return Right(productEntityList);
    } catch (e) {
      log('Exception in ProductRepoImpl.getProducts: ${e.toString()}');
      return Left(ServerFailure('Failed to fetch products'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getFeaturedProducts() async {
    try {
      var products =
          await databaseService.getData(
                path: BackendEndpoints.featuredProducts,
                query: {'whereField': 'is_featured', 'whereValue': true},
              )
              as List<Map<String, dynamic>>;
      var productEntityList = products
          .map((product) => ProductModel.fromJson(product).toEntity())
          .toList();
      return Right(productEntityList);
    } catch (e) {
      log('Exception in ProductRepoImpl.getFeaturedProducts: ${e.toString()}');
      return Left(ServerFailure('Failed to fetch featured products'));
    }
  }
}
