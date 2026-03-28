class ShippingOption {
  const ShippingOption({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isFree,
  });

  final String title;
  final String subtitle;
  final String price;
  final bool isFree;
}
