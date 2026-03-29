enum OrderStatus {
  pending,
  confirmed,
  shipped,
  outForDelivery,
  delivered;

  static OrderStatus fromString(String value) {
    return switch (value.toLowerCase().trim()) {
      'confirmed' => OrderStatus.confirmed,
      'shipped' => OrderStatus.shipped,
      'out_for_delivery' => OrderStatus.outForDelivery,
      'delivered' => OrderStatus.delivered,
      _ => OrderStatus.pending,
    };
  }

  String get label => switch (this) {
    OrderStatus.pending => 'تتبع الطلب',
    OrderStatus.confirmed => 'قبول الطلب',
    OrderStatus.shipped => 'تم شحن الطلب',
    OrderStatus.outForDelivery => 'خرج للتوصيل',
    OrderStatus.delivered => 'تم تسليم',
  };

  String get description => switch (this) {
    OrderStatus.pending => 'جارٍ مراجعة طلبك',
    OrderStatus.confirmed => 'تم قبول طلبك',
    OrderStatus.shipped => 'طلبك في الطريق',
    OrderStatus.outForDelivery => 'قيد الانتظار',
    OrderStatus.delivered => 'تم التسليم بنجاح',
  };

  bool get isCompleted => index <= OrderStatus.delivered.index;
}
