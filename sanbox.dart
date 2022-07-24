import 'dart:convert';

List<Country> countries = [
  Country(
    name: "Austria",
    flag: "AT",
    prefixCode: "AT",
    validationFunction: (vat) {
      if(vat[0] != "U") return false;
      return int.tryParse(vat.substring(1, vat.length)) != null;
    },
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Belgium",
    flag: "BE",
    prefixCode: "BE",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Bulgaria",
    flag: "BG",
    prefixCode: "BG",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 9,
    maxLength: 10,
  ),
  Country(
    name: "Croatia",
    flag: "HR",
    prefixCode: "HR",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "Cyprus",
    flag: "CY",
    prefixCode: "CY",
    // Last must be a letter
    validationFunction: (vat) {
      bool lastIsLetter = !vat
          .substring(vat.length - 1, vat.length)
          .toUpperCase()
          .contains(r'[0-9]');
          
        return lastIsLetter && int.tryParse(vat.substring(0, vat.length - 1)) != null;
    },
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Czech Republic",
    flag: "CZ",
    prefixCode: "CZ",
    //if more than 10 chars, delete first three
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 8,
    maxLength: 14,
  ),
  Country(
    name: "Denmark",
    flag: "DK",
    prefixCode: "DK",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Estonia",
    flag: "EE",
    prefixCode: "EE",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Finland",
    flag: "FI",
    prefixCode: "FI",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 8,
    maxLength: 8,
  ),
  Country(
      name: "France",
      flag: "FR",
      prefixCode: "FR",
      // can have letters on first and/or second char (but never "O" or "I")
      minLength: 11,
      maxLength: 11,
      validationFunction: (vat) {
        if (vat.contains("O") || vat.contains("I")) return false;
        bool firstIsLetter =
            !vat.substring(0, 1).toUpperCase().contains(r'[0-9]');
        if (firstIsLetter) return true;
        bool lastIsLetter = !vat
            .substring(vat.length - 1, vat.length)
            .toUpperCase()
            .contains(r'[0-9]');

        return lastIsLetter;
      }),
  Country(
    name: "Germany",
    flag: "DE",
    prefixCode: "DE",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Greece",
    flag: "GR",
    prefixCode: "EL",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Hungary",
    flag: "HU",
    prefixCode: "HU",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Ireland",
    flag: "IE",
    prefixCode: "IE",
    // last 2 can be letters. At least one letter
    validationFunction: (vat) {
      bool lastIsLetter = !vat
          .substring(vat.length - 1, vat.length)
          .toUpperCase()
          .contains(r'[0-9]');
      if (lastIsLetter) return true;
      bool secondLastIsLetter = !vat
          .substring(vat.length - 2, vat.length - 1)
          .toUpperCase()
          .contains(r'[0-9]');
      return secondLastIsLetter;
    },
    minLength: 8,
    maxLength: 9,
  ),
  Country(
    name: "Italy",
    flag: "IT",
    prefixCode: "IT",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "Latvia",
    flag: "LV",
    prefixCode: "LV",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "Lithuania",
    flag: "LT",
    prefixCode: "LT",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 9,
    maxLength: 12,
  ),
  Country(
    name: "Luxembourg",
    flag: "LU",
    prefixCode: "LU",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Malta",
    flag: "MT",
    prefixCode: "MT",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Netherlands",
    flag: "NL",
    prefixCode: "NL",
    // the 10th caracter is always B
    // Can end with BO2
    validationFunction: (vat) {
      bool containsBatPos10 = vat[9] == "B";
      bool containsOorNumberAtPos11 =
          vat[10] == "O" || int.tryParse(vat[10]) != null;
      return containsBatPos10 && containsOorNumberAtPos11;
    },
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "Norway",
    flag: "NO",
    prefixCode: "",
    sufixCode: "MVA",
    validationFunction: (vat) {
      int? value = int.tryParse(vat);
      if (value == null) return false;
      return modValidation(vat);
    },
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Poland",
    flag: "PL",
    prefixCode: "PL",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Portugal",
    flag: "PT",
    prefixCode: "PT",
    minLength: 9,
    maxLength: 9,
    validationFunction: (vat) {
      int? value = int.tryParse(vat);
      if (value == null) return false;
      return modValidation(vat);
    },
  ),
  Country(
    name: "Romania",
    flag: "RO",
    prefixCode: "RO",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Slovakia",
    flag: "SK",
    prefixCode: "SK",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Slovenia",
    flag: "SI",
    prefixCode: "SI",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Spain",
    flag: "ES",
    prefixCode: "ES",
    // first and/or last can be letters (must contain al least one)
    validationFunction: (vat) {
      bool firstIsLetter =
          !vat.substring(0, 1).toUpperCase().contains(r'[0-9]');
      if (firstIsLetter) return true;
      bool lastIsLetter = !vat
          .substring(vat.length - 1, vat.length)
          .toUpperCase()
          .contains(r'[0-9]');
      return lastIsLetter;
    },
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Sweden",
    flag: "SE",
    prefixCode: "SE",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "Switzerland (German)",
    flag: "CH",
    prefixCode: "CHE",
    sufixCode: "MWST",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Switzerland (French)",
    flag: "CH",
    prefixCode: "CHE",
    sufixCode: "TVA",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Switzerland (Italian)",
    flag: "CH",
    prefixCode: "CHE",
    sufixCode: "IVA",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "United Kingdom",
    flag: "GB",
    prefixCode: "GB",
    validationFunction: (vat) {
      return int.tryParse(vat) != null;
    },
    minLength: 9,
    maxLength: 9,
  ),
];

class Country {
  final String name;
  final String flag;
  final String prefixCode;
  final String sufixCode;
  final bool Function(String contentValue)? validationFunction;
  final int minLength;
  final int maxLength;

  const Country({
    required this.name,
    required this.flag,
    required this.prefixCode,
    this.sufixCode = "",
    required this.minLength,
    required this.maxLength,
    this.validationFunction,
  });

  String extractContentVAT(String vat) {
    String value = vat.replaceAll(sufixCode, '').replaceAll(prefixCode, '');
    if (prefixCode == "CZ" && value.length > 10) {
      // 8, 9 or 10 characters If more than 10 characters are provided delete the first 3
      value = value.substring(3);
    }
    return value;
  }

  static Country? from(String vat) {
    // Check only country with 3 letter sufixCode code at start
    if (vat.contains('CHE')) {
      // print("    > Contains 'CHE'");
      String suffix = vat.substring(vat.length - 3, vat.length);
      String suffix2 = vat.substring(vat.length - 4, vat.length);
      // print("    > Suffixes may be '$suffix' or '$suffix2'");
      List<Country> possibilities = countries
          .where((c) =>
              c.prefixCode == 'CHE' &&
              (c.sufixCode == suffix || c.sufixCode == suffix2))
          .toList();

      // print(possibilities.isEmpty ? "    > None found" : "");
      return possibilities.isEmpty ? null : possibilities.first;
    }

    // Check the only country that doesn't have prefixCode
    String prefix = vat.substring(0, 2);

    if (vat.substring(vat.length - 3, vat.length) == 'MVA') {
      String suffix = vat.substring(vat.length - 3, vat.length);

      List<Country> possibilities = countries
          .where((c) => c.prefixCode.isEmpty && c.sufixCode == suffix)
          .toList();
      return possibilities.isEmpty ? null : possibilities.first;
    }
    // All the other
    List<Country> possibilities =
        countries.where((c) => c.prefixCode == prefix).toList();
    return possibilities.isEmpty ? null : possibilities.first;
  }
}

void main() {
  List<String> vats = [
    "ESX12345678",
    "ESX1234567X",
    "ES01234567X",
    "CHE123456789IVA",
    "CHE123456789TVA",
    "CHE123456789MWST",
    "ATU12345678",
    "BE1234567890",
    "CZ1234567890",
    "FRXX123456789",
    "PT268594376",
    "NL123456789B01",
    "NL123456789BO2",
    "123456789MVA",
    "IE1234567WA",
    "IE1234567FA",
    "FR12345678901",
    "FRX1234567890",
    "FR1X123456789",
    "FRXX123456789",
    "CZ12345678",
    "CZ123456789",
    "CZ1234567890",
    "CY12345678X",
    "HR12345678901",
    "BG123456789",
    "BG1234567890",
    "BE1234567890",
    "BE0123456789",
    "ATU12345678",
    "MT12345678",
  ];
  vats.forEach((vat) {
    Country? c = Country.from(vat);
    if (c == null) {
      print("COULD NOT FIND COUNTRY FOR >> '$vat'");
      return;
    }
    print(
        "${c.name}\t\t| VALID=${c.validationFunction == null ? "NaN" : c.validationFunction!(c.extractContentVAT(vat))}");
  });
}

bool modValidation(String nifStr) {
  List<int> nif = convertStringToListInt(nifStr);
  if (nif.length == 9) {
    // ignore special cases 4 and 7.
    var added = ((nif[7] * 2) +
        (nif[6] * 3) +
        (nif[5] * 4) +
        (nif[4] * 5) +
        (nif[3] * 6) +
        (nif[2] * 7) +
        (nif[1] * 8) +
        (nif[0] * 9));
    var mod = added % 11;
    var control;
    if (mod == 0 || mod == 1) {
      control = 0;
    } else {
      control = 11 - mod;
    }

    if (nif[8] == control) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

List<int> convertStringToListInt(String s) {
  List<int> lst = [];
  for (int i = 0; i < s.length; i++) {
    int value = int.parse(utf8.decode([s.codeUnitAt(i)]));
    lst.add(value);
  }

  return lst;
}
