class ShippingAddressEntity {
  String? name;
  String? email;
  String? address;
  String? city;
  String? addressDetails;
  String? phone;

  ShippingAddressEntity({
    this.name,
    this.email,
    this.address,
    this.city,
    this.addressDetails,
    this.phone,
  });

  String get formattedAddress => '$address $addressDetails, مدينة $city';
}
