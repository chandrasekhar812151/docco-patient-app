import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';

class CountryPicker extends StatefulWidget {
  CountryPicker(this.countryIsoCode, { required this.onChanged });

  final Function onChanged;
  final String countryIsoCode;

  @override
  _CountryPicker createState() => _CountryPicker();
}

class _CountryPicker extends State<CountryPicker> {

  Country? _selectedDialogCountry;

  @override
  void initState() {
    super.initState();
    print(widget.countryIsoCode);
    _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode(widget.countryIsoCode);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text('COUNTRY', style: Theme.of(context).textTheme.bodySmall,),
          ),
          ListTile(
            onTap: _openCountryPickerDialog,
            title: _buildDialogItem(_selectedDialogCountry!),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
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
                  widget.onChanged(country);
                  setState(() => _selectedDialogCountry = country);
                },
                itemBuilder: _buildDialogItem)),
      );
}
