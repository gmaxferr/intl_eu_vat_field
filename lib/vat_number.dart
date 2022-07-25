import 'package:intl_eu_vat_field/countries.dart';

class VATNumber {
  Country country;
  String number;

  VATNumber({
    required this.country,
    required this.number,
  });

  String get completeNumber {
    return country.prefixCode + number + country.sufixCode;
  }

  String toString() => 'VAT(country: Country[${country.name}], number: $number)';
}
