class VATNumber {
  String countryCode;
  String number;

  VATNumber({
    required this.countryCode,
    required this.number,
  });

  String get completeNumber {
    return countryCode + number;
  }

  String toString() =>
      'VAT(countryCode: $countryCode, number: $number)';
}
