import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/order_tracking_entity/order_status.dart';
import '../../../domain/entities/order_tracking_entity/order_tracking_entity.dart';

class OrderTrackingModel {
  static OrderTrackingEntity fromDoc(String docId, Map<String, dynamic> data) {
    return _parse(
      orderId: docId,
      data: data,
      createdAt: _parseFsTimestamp(data['created_at']),
    );
  }

  static OrderTrackingEntity fromMap(
    String orderId,
    Map<String, dynamic> data,
  ) {
    return _parse(
      orderId: orderId,
      data: data,
      createdAt: _parseRtdbTimestamp(data['created_at']),
    );
  }

  // ── Shared parser ──────────────────────────────────────────────────────────

  static OrderTrackingEntity _parse({
    required String orderId,
    required Map<String, dynamic> data,
    required DateTime? createdAt,
  }) {
    return OrderTrackingEntity(
      orderId: orderId,
      totalPrice: (data['total_price'] as num?) ?? 0,
      shippingFee: _parseShippingFee(data['pay_method'] as String?),
      itemCount: (data['items'] as List?)?.length ?? 0,
      payMethod: data['pay_method'] as String? ?? '',
      status: OrderStatus.fromString(data['status'] as String? ?? ''),
      deliveryAddress: _parseAddress(data['shipping_address']),
      createdAt: createdAt,
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  static num _parseShippingFee(String? payMethod) {
    return payMethod?.toLowerCase() == 'cash' ? 40 : 0;
  }

  static String _parseAddress(dynamic raw) {
    if (raw is! Map<String, dynamic>) return '';
    final city = raw['city'] as String? ?? '';
    final state = raw['state'] as String? ?? '';
    return '$state، $city'.trim().replaceAll(RegExp(r'^،\s*|،\s*$'), '');
  }

  static DateTime? _parseFsTimestamp(dynamic raw) =>
      raw is Timestamp ? raw.toDate() : null;

  static DateTime? _parseRtdbTimestamp(dynamic raw) =>
      raw is int ? DateTime.fromMillisecondsSinceEpoch(raw) : null;
}
