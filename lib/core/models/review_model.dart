import 'package:hive_ce/hive.dart';

import '../entities/review_entity.dart';
part 'review_model.g.dart';

@HiveType(typeId: 4)
class ReviewModel {
  @HiveField(0)
  final String customerName;

  @HiveField(1)
  final num ratting;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String date;

  ReviewModel({
    required this.customerName,
    required this.ratting,
    required this.description,
    required this.date,
  });

  // ── Entity Mapping ──────────────────────────────────────────────────────

  ReviewEntity toEntity() => ReviewEntity(
    customerName: customerName,
    ratting: ratting,
    description: description,
    date: date,
  );

  factory ReviewModel.fromEntity(ReviewEntity entity) {
    return ReviewModel(
      customerName: entity.customerName,
      ratting: entity.ratting,
      description: entity.description,
      date: entity.date,
    );
  }

  // ── Json Mapping ────────────────────────────────────────────────────────────────
  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    customerName: json['customer_name'] as String,
    ratting: json['ratting'] as num,
    description: json['description'] as String,
    date: json['date'] as String,
  );

  Map<String, dynamic> toJson() {
    return {
      'customer_name': customerName,
      'ratting': ratting,
      'description': description,
      'date': date,
    };
  }
}
