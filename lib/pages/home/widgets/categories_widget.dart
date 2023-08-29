import 'package:doctor_patient/bloc/doctor_search_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/pages/doctor_search/doctor_search_page.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:flutter/material.dart';

List<Map> _categories = [
  {
    'name': 'Ayurveda',
    'image': UIData.ayurvedaImage
  },
  {
    'name': 'Homeopathy',
    'image': UIData.homeopathyImage
  },
  {
    'name': 'Naturopathy',
    'image': UIData.naturopathyImage
  }
];

class CategoriesWidget extends StatelessWidget {
  EdgeInsetsGeometry getSpacing(index, length) {
    if (index == 0) {
      return EdgeInsets.only(left: 16, right: 4);
    } else if (index == length - 1) {
      return EdgeInsets.only(right: 16, left: 4);
    }

    return EdgeInsets.symmetric(horizontal: 4);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = sl<DoctorSearchBloc>();
    final textTheme = Theme.of(context).textTheme;
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'What are you looking for?',
              style: textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List<Widget>.generate(_categories.length, (index) {
                return GestureDetector(
                  onTap: () {
                    bloc.updateCategory(_categories[index]['name']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorSearchPage()),
                    );
                  },
                  child: Container(
                      margin: getSpacing(index, _categories.length),
                      width: 110,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.all(0),
                        child: Stack(
                          children: <Widget>[
                            Image.asset(
                              _categories[index]['image'],
                              fit: BoxFit.fitHeight,
                              height: double.infinity,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.3),
                                child: Text(
                                  _categories[index]['name'],
                                  style: textTheme.titleMedium?.copyWith(
                                    color: Colors.white
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                );
              }),
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
