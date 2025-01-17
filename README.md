# International Phone Field Package

![Pub](https://img.shields.io/pub/v/intl_eu_vat_field)

A customised Flutter TextFormField to input european VAT numbers validated according to EU Guidelines.

This widget can be used to make customised text field to take vat number input for any EU country along with an option to choose country code from a dropdown.

## Screenshots

<img src="https://github.com/gmaxferr/intl_eu_vat_field/blob/master/1.png?raw=true" height="500px"> <img src="https://github.com/gmaxferr/intl_eu_vat_field/blob/master/2.png?raw=true" height="500px"> <img src="https://github.com/gmaxferr/intl_eu_vat_field/blob/master/3.png?raw=true" height="500px">

## Installing

To use this package:

Run this command:

```yaml
flutter pub add intl_eu_vat_field
```

Or, add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  intl_eu_vat_field: ^1.0.2
```

## How to Use

Simply create a `IntlVatNumberField` widget, and pass the required params:

```dart
IntlVatNumberField(
    decoration: InputDecoration(
        labelText: 'VAT Number',
        border: OutlineInputBorder(
            borderSide: BorderSide(),
        ),
    ),
    initialCountryCode: 'PT',
    onChanged: (phone) {
        print(phone.completeNumber);
    },
)
```

Use `initialCountryCode` to set an initial Country Code.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

Comment on Issue or Pull Request, asking @all-contributors to add a contributor:

```shell
@all-contributors please add @<username> for <contributions>
```

**\<contributions>**: See the [Emoji Key (Contribution Types Reference)](https://allcontributors.org/docs/en/emoji-key) for a list of valid contribution types.

## CONTRIBUTORS

- [Guilherme Ferreira](https://github.com/gmaxferr/)

## LICENSE

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
