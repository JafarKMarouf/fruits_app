import '../entities/product_entity.dart';
import 'review_model.dart';

class ProductModel {
  final String name;
  final double price;
  final int quantity;
  final String description;
  String? imageUrl;
  final bool isFeatured;
  final String code;
  final int expirationMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final int unitAmount;
  final num avgRate;
  final num countRate;
  final int sellingCount;
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

  // ── Mapping ────────────────────────────────────────────────────────────────

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
}
