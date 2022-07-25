import 'package:flutter/material.dart';
import 'package:intl_eu_vat_field/countries.dart';

class PickerDialogStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class VATPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;

  VATPickerDialog({
    Key? key,
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  }) : super(key: key);

  @override
  _VATPickerDialogState createState() => _VATPickerDialogState();
}

class _VATPickerDialogState extends State<VATPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final width = widget.style?.width ?? mediaWidth;
    final defaultHorizontalPadding = 40.0;
    final defaultVerticalPadding = 24.0;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: defaultVerticalPadding,
          horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
              ? (mediaWidth - width) / 2
              : defaultHorizontalPadding),
      backgroundColor: widget.style?.backgroundColor,
      child: Container(
        padding: widget.style?.padding ?? EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: widget.style?.searchFieldPadding ?? EdgeInsets.all(0),
              child: TextField(
                cursorColor: widget.style?.searchFieldCursorColor,
                decoration: widget.style?.searchFieldInputDecoration ??
                    InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      labelText: widget.searchText,
                    ),
                onChanged: (value) {
                  _filteredCountries = widget.countryList
                          .where((country) => country.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                  if (this.mounted) setState(() {});
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCountries.length,
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        'assets/flags/${_filteredCountries[index].flag.toLowerCase()}.png',
                        package: 'intl_eu_vat_field',
                        width: 32,
                      ),
                      contentPadding: widget.style?.listTilePadding,
                      title: Text(
                        _filteredCountries[index].name,
                        style: widget.style?.countryNameStyle ??
                            TextStyle(fontWeight: FontWeight.w700),
                      ),
                      trailing: Text(
                        '${_filteredCountries[index].prefixCode}....${_filteredCountries[index].sufixCode}',
                        style: widget.style?.countryCodeStyle ??
                            TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onTap: () {
                        _selectedCountry = _filteredCountries[index];
                        widget.onCountryChanged(_selectedCountry);
                        Navigator.of(context).pop();
                      },
                    ),
                    widget.style?.listTileDivider ?? Divider(thickness: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
