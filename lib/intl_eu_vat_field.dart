library intl_eu_vat_field;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_eu_vat_field/country_picker_dialog.dart';

import './countries.dart';
import 'vat_number.dart';

class IntlVatNumberField extends StatefulWidget {
  /// Whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;
  final VoidCallback? onTap;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;
  final FormFieldSetter<VATNumber>? onSaved;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted], [onSelectionChanged]:
  ///    which are more specialized input change notifications.
  final ValueChanged<VATNumber>? onChanged;

  final ValueChanged<Country>? onCountryChanged;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  ///
  /// A [VATNumber] is passed to the validator as argument.
  /// The validator can handle asynchronous validation when declared as a [Future].
  /// Or run synchronously when declared as a [Function].
  ///
  /// By default, the validator checks whether the input number length is between selected country's vatnumber numbers min and max length.
  /// If `disableLengthCheck` is not set to `true`, your validator returned value will be overwritten by the default validator.
  /// But, if `disableLengthCheck` is set to `true`, your validator will have to check vatnumber number length itself.
  final FutureOr<String?> Function(VATNumber?)? validator;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field.  The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [EditableText.onSubmitted] for an example of how to handle moving to
  ///    the next/previous field when using [TextInputAction.next] and
  ///    [TextInputAction.previous] for [textInputAction].
  final void Function(String)? onSubmitted;

  /// If false the widget is "disabled": it ignores taps, the [TextFormField]'s
  /// [decoration] is rendered in grey,
  /// [decoration]'s [InputDecoration.counterText] is set to `""`,
  /// and the drop down icon is hidden no matter [showDropdownIcon] value.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.brightness].
  final Brightness? keyboardAppearance;

  /// Initial Value for the field.
  /// This property can be used to pre-fill the field.
  final String? initialValue;

  /// 2 Letter ISO Code
  final String? initialCountryCode;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// Disable view Min/Max Length check
  final bool disableLengthCheck;

  /// Won't work if [enabled] is set to `false`.
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;

  /// The style use for the country dial code.
  final TextStyle? dropdownTextStyle;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// The text that describes the search input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on top of the input field (i.e., at the same location on the screen where text may be entered in the input field).
  /// When the input field receives focus (or if the field is non-empty), the label moves above (i.e., vertically adjacent to) the input field.
  final String searchText;

  /// Position of an icon [leading, trailing]
  final IconPosition dropdownIconPosition;

  /// Icon of the drop down button.
  ///
  /// Default is [Icon(Icons.arrow_drop_down)]
  final Icon dropdownIcon;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Autovalidate mode for text form field.
  ///
  /// If [AutovalidateMode.onUserInteraction], this FormField will only auto-validate after its content changes.
  /// If [AutovalidateMode.always], it will auto-validate even without user interaction.
  /// If [AutovalidateMode.disabled], auto-validation will be disabled.
  ///
  /// Defaults to [AutovalidateMode.onUserInteraction].
  final AutovalidateMode? autovalidateMode;

  /// Whether to show or hide country flag.
  ///
  /// Default value is `true`.
  final bool showCountryFlag;

  /// Whether to show complete Country name or a shorter version.
  ///
  /// Default value is `false`.
  final bool showShorterCountryName;

  /// Message to be displayed on autoValidate error
  ///
  /// Default value is `Invalid Mobile Number`.
  final String? invalidNumberMessage;

  /// The color of the cursor.
  final Color? cursorColor;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// How rounded the corners of the cursor should be.
  final Radius? cursorRadius;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// Whether to show cursor.
  final bool? showCursor;

  /// The padding of the Flags Button.
  ///
  /// The amount of insets that are applied to the Flags Button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry flagsButtonPadding;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Optional set of styles to allow for customizing the country search
  /// & pick dialog
  final PickerDialogStyle? pickerDialogStyle;

  /// The margin of the country selector button.
  ///
  /// The amount of space to surround the country selector button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsets flagsButtonMargin;

  IntlVatNumberField({
    Key? key,
    this.initialCountryCode,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.style,
    this.dropdownTextStyle,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onCountryChanged,
    this.onSaved,
    this.showShorterCountryName = false,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance,
    @Deprecated('Use searchFieldInputDecoration of PickerDialogStyle instead') this.searchText = 'Search country',
    this.dropdownIconPosition = IconPosition.leading,
    this.dropdownIcon = const Icon(Icons.arrow_drop_down),
    this.autofocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showCountryFlag = true,
    this.cursorColor,
    this.disableLengthCheck = false,
    this.flagsButtonPadding = EdgeInsets.zero,
    this.invalidNumberMessage = 'Invalid VAT Number',
    this.cursorHeight,
    this.cursorRadius = Radius.zero,
    this.cursorWidth = 2.0,
    this.showCursor = true,
    this.pickerDialogStyle,
    this.flagsButtonMargin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  _IntlVatNumberFieldState createState() => _IntlVatNumberFieldState();
}

class _IntlVatNumberFieldState extends State<IntlVatNumberField> {
  late List<Country> _countryList;
  late Country _selectedCountry;
  late List<Country> filteredCountries;
  late String number;

  String? validatorMessage;

  @override
  void initState() {
    super.initState();
    _countryList = countries;
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      // parse initial value
      Country? c;
      try {
        c = Country.from(number);
      } catch (err) {}
      _selectedCountry = c ?? countries.firstWhere((c) => c.name == "Malta", orElse: () => countries.first);
      number = number.replaceAll(_selectedCountry.prefixCode, '').replaceAll(_selectedCountry.sufixCode, '');
    } else {
      _selectedCountry = _countryList.firstWhere((item) => item.prefixCode == (widget.initialCountryCode ?? 'MT'), orElse: () => _countryList.first);
    }
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      final initialVATNumber = VATNumber(
        country: _selectedCountry,
        number: widget.initialValue ?? '',
      );

      _validateNewVat(_selectedCountry, initialVATNumber);
      widget.onChanged?.call(initialVATNumber);
      setState(() {});
    });
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => VATPickerDialog(
          style: widget.pickerDialogStyle,
          filteredCountries: filteredCountries,
          searchText: widget.searchText,
          countryList: _countryList,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            _selectedCountry = country;
            final newVAT = VATNumber(country: country, number: number);
            _validateNewVat(country, newVAT);
            widget.onChanged?.call(newVAT);
            widget.onCountryChanged?.call(country);
            setState(() {});
          },
        ),
      ),
    );
    if (this.mounted) setState(() {});
  }

  final _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formKey,
      initialValue: (widget.controller == null) ? number : null,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      cursorColor: widget.cursorColor,
      onTap: widget.onTap,
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      showCursor: widget.showCursor,
      onFieldSubmitted: widget.onSubmitted,
      decoration: widget.decoration.copyWith(
        prefixIcon: _buildFlagsButton(),
        errorText: validatorMessage,
        suffix: _selectedCountry.sufixCode.isEmpty
            ? null
            : Text(
                _selectedCountry.sufixCode,
                style: widget.dropdownTextStyle,
              ),
        counterText: !widget.enabled ? '' : null,
      ),
      style: widget.style,
      onSaved: (value) {
        widget.onSaved?.call(
          VATNumber(
            country: _selectedCountry,
            number: value!,
          ),
        );
      },
      onChanged: (value) async {
        number = value;
        final vatNumber = VATNumber(
          country: _selectedCountry,
          number: value,
        );

        _validateNewVat(_selectedCountry, vatNumber);

        widget.onChanged?.call(vatNumber);
      },
      validator: (value) {
        bool validLength = true;
        if (!widget.disableLengthCheck && value != null) {
          validLength = value.length >= _selectedCountry.minLength && value.length <= _selectedCountry.maxLength;
        }
        if (!validLength) {
          validatorMessage = widget.invalidNumberMessage;
          return validatorMessage;
        }
        print(value);
        if (value != null && value.isNotEmpty && !_selectedCountry.validationFunction!(value)) {
          validatorMessage = widget.invalidNumberMessage;
          return validatorMessage;
        }

        validatorMessage = null;
        Future.delayed(Duration(milliseconds: 300), () => setState(() {}));
        return validatorMessage;
      },
      maxLength: widget.disableLengthCheck ? null : _selectedCountry.maxLength,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      keyboardAppearance: widget.keyboardAppearance,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      autovalidateMode: widget.autovalidateMode,
    );
  }

  void _validateNewVat(Country country, VATNumber vatNumber) async {
    if (widget.autovalidateMode != AutovalidateMode.disabled) {
      if (widget.validator == null && _selectedCountry.validationFunction != null) {
        String str = _selectedCountry.extractContentVAT(vatNumber.number);
        bool valid =
            str.length >= _selectedCountry.minLength && str.length <= _selectedCountry.maxLength && _selectedCountry.validationFunction!(str);
        print(
            "Attempt => '${_selectedCountry.extractContentVAT(vatNumber.number)}' | ${valid ? "VALID" : "INVALID"}\n  > completeNumber: ${vatNumber.completeNumber} | countryCode: ${vatNumber.country.name} | number: ${vatNumber.number}");
        if (!valid) {
          validatorMessage = widget.invalidNumberMessage;
        } else {
          validatorMessage = null;
        }
      } else {
        validatorMessage = await widget.validator?.call(vatNumber);
      }
    }
  }

  Container _buildFlagsButton() {
    return Container(
      margin: widget.flagsButtonMargin,
      child: DecoratedBox(
        decoration: widget.dropdownDecoration,
        child: InkWell(
          borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
          child: Padding(
            padding: widget.flagsButtonPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.enabled && widget.showDropdownIcon && widget.dropdownIconPosition == IconPosition.leading) ...[
                  widget.dropdownIcon,
                  SizedBox(width: 4),
                ],
                if (widget.showCountryFlag) ...[
                  Image.asset(
                    'assets/flags/${_selectedCountry.flag.toLowerCase()}.png',
                    package: 'intl_eu_vat_field',
                    width: 32,
                  ),
                  SizedBox(width: 8),
                ],
                FittedBox(
                  child: Text(
                    widget.showShorterCountryName
                        ? '${_selectedCountry.shortenedName}  ${_selectedCountry.prefixCode}'
                        : '${_selectedCountry.name}  ${_selectedCountry.prefixCode}',
                    style: widget.dropdownTextStyle,
                  ),
                ),
                if (widget.enabled && widget.showDropdownIcon && widget.dropdownIconPosition == IconPosition.trailing) ...[
                  SizedBox(width: 4),
                  widget.dropdownIcon,
                ],
                SizedBox(width: 8),
              ],
            ),
          ),
          onTap: widget.enabled ? _changeCountry : null,
        ),
      ),
    );
  }
}

enum IconPosition {
  leading,
  trailing,
}
