import '../entities/review_enitity.dart';

class ReviewModel {
  final String customerName;
  final String customerImage;
  final num ratting;
  final String description;
  final String date;

  ReviewModel({
    required this.customerName,
    required this.customerImage,
    required this.ratting,
    required this.description,
    required this.date,
  });

  // ── Mapping ────────────────────────────────────────────────────────────────
  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    customerName: json['customer_name'] as String,
    customerImage: json['customer_image'] as String,
    ratting: json['ratting'] as num,
    description: json['description'] as String,
    date: json['date'] as String,
  );

  // ── Mapping to Entity ──────────────────────────────────────────────────────
  ReviewEntity toEntity() => ReviewEntity(
    customerName: customerName,
    customerImage: customerImage,
    ratting: ratting,
    description: description,
    date: date,
  );
}
