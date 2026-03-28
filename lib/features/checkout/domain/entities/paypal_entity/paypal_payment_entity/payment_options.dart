class PaymentOptions {
  String? allowedPaymentMethod;

  PaymentOptions({this.allowedPaymentMethod});

  Map<String, dynamic> toJson() => {
    'allowed_payment_method': allowedPaymentMethod,
  };
}
