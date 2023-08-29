import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';

class PhoneNumberEditor extends StatefulWidget {
  PhoneNumberEditor({
    this.text,
    this.onChanged,
    this.prefixIcon
  });

  final Function? onChanged;
  final String? text;
  final Icon? prefixIcon;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PhoneNumberEditor> {
  Country _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('in');
  String? _phoneNumber;
  final _textCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textCtrl.text = widget.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  labelText: 'Phone',
                  hintText: 'Enter your mobile number',
                  prefix: InkWell(
                    onTap: _openCountryPickerDialog,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CountryPickerUtils.getDefaultFlagImage(
                            _selectedDialogCountry),
                        SizedBox(width: 8.0),
                        Text("+${_selectedDialogCountry.phoneCode}"),
                      ],
                    ),
                  ),
                  prefixIcon: widget.prefixIcon ??  Icon(Icons.account_circle),
                ),
                keyboardType: TextInputType.phone,
                onChanged: (p) {
                  _phoneNumber = p;
                  if (_phoneNumber == '') {
                    widget.onChanged!('');
                  } else {
                    widget.onChanged!(
                      '${_selectedDialogCountry.phoneCode}$_phoneNumber');
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CountryPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your phone code'),
                onValuePicked: (Country country) {
                  setState(() => _selectedDialogCountry = country);
                  widget.onChanged!(
                      '${_selectedDialogCountry.phoneCode}$_phoneNumber');
                },
                itemBuilder: _buildDialogItem)),
      );
}
