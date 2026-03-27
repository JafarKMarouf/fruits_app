import '../../../../core/l10n/l10n.dart';

class ShippingAddressEntity {
  String? name;
  String? email;
  String? phone;
  String? state;
  String? city;

  ShippingAddressEntity({
    this.name,
    this.email,
    this.phone,
    this.state,
    this.city,
  });
  String formattedAddress(AppLocalizations l10n) {
    return l10n.formattedAddress(state ?? '', city ?? '');
  }
}
