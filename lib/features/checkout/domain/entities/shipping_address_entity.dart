import '../../../../core/l10n/l10n.dart';

class ShippingAddressEntity {
  String? name;
  String? email;
  String? street;
  String? city;
  String? floor;
  String? phone;

  ShippingAddressEntity({
    this.name,
    this.email,
    this.street,
    this.city,
    this.floor,
    this.phone,
  });
  String formattedAddress(AppLocalizations l10n) {
    return l10n.formattedAddress(street ?? '', floor ?? '', city ?? '');
  }
}
