import 'package:hive_ce/hive.dart';

import '../entities/product_entity.dart';
import 'review_model.dart';

part 'product_model.g.dart';

@HiveType(typeId: 3)
class ProductModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double price;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final String description;

  @HiveField(4)
  String? imageUrl;

  @HiveField(5)
  final bool isFeatured;

  @HiveField(6)
  final String code;

  @HiveField(7)
  final int expirationMonths;

  @HiveField(8)
  final bool isOrganic;

  @HiveField(9)
  final int numberOfCalories;

  @HiveField(10)
  final int unitAmount;

  @HiveField(11)
  final num avgRate;

  @HiveField(12)
  final num countRate;

  @HiveField(13)
  final int sellingCount;

  @HiveField(14)
  final List<ReviewModel> reviews;

  ProductModel({
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.isFeatured,
    required this.code,
    this.imageUrl,
    required this.expirationMonths,
    required this.numberOfCalories,
    required this.unitAmount,
    this.isOrganic = false,
    this.avgRate = 0,
    this.countRate = 0,
    this.sellingCount = 0,
    required this.reviews,
  });

  // ── Entity Mapping ────────────────────────────────────────────────────────────────

  ProductEntity toEntity() => ProductEntity(
    name: name,
    price: price,
    quantity: quantity,
    description: description,
    imageUrl: imageUrl,
    isFeatured: isFeatured,
    code: code,
    expirationMonths: expirationMonths,
    numberOfCalories: numberOfCalories,
    unitAmount: unitAmount,
    isOrganic: isOrganic,
    avgRate: avgRate,
    countRate: countRate,
    reviews: reviews.map((e) => e.toEntity()).toList(),
  );

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      name: entity.name,
      price: entity.price,
      quantity: entity.quantity,
      description: entity.description,
      imageUrl: entity.imageUrl,
      isFeatured: entity.isFeatured,
      code: entity.code,
      expirationMonths: entity.expirationMonths,
      numberOfCalories: entity.numberOfCalories,
      unitAmount: entity.unitAmount,
      isOrganic: entity.isOrganic,
      avgRate: entity.avgRate,
      countRate: entity.countRate,
      reviews: entity.reviews.map((e) => ReviewModel.fromEntity(e)).toList(),
    );
  }

  // ── JSON Mapping ───────────────────────────────
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
    quantity: json['quantity'] as int,
    description: json['description'] as String,
    imageUrl: json['image_url'] as String?,
    isFeatured: json['is_featured'] as bool,
    code: json['code'] as String,
    expirationMonths: json['expiration_months'] as int,
    numberOfCalories: json['number_of_calories'] as int,
    unitAmount: json['unit_amount'] as int,
    isOrganic: json['is_organic'] as bool? ?? false,
    avgRate: json['avg_rate'] as num? ?? 0,
    countRate: json['count_rate'] as num? ?? 0,
    sellingCount: json['selling_count'] as int? ?? 0,
    reviews:
        (json['reviews'] as List<dynamic>?)
            ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'description': description,
      'image_url': imageUrl,
      'is_featured': isFeatured,
      'code': code,
      'expiration_months': expirationMonths,
      'number_of_calories': numberOfCalories,
      'unit_amount': unitAmount,
      'is_organic': isOrganic,
      'avg_rate': avgRate,
      'count_rate': countRate,
      'selling_count': sellingCount,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}
