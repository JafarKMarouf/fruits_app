import '../../../domain/entities/order_input_entity/shipping_address_entity.dart';

class ShippingAddressModel {
  String? name;
  String? email;
  String? phone;
  String? state;
  String? city;

  ShippingAddressModel({
    this.name,
    this.email,
    this.phone,
    this.state,
    this.city,
  });

  factory ShippingAddressModel.fromEntity(ShippingAddressEntity entity) {
    return ShippingAddressModel(
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      state: entity.state,
      city: entity.city,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'state': state,
      'city': city,
    };
  }
}
