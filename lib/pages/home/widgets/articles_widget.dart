import 'package:flutter/material.dart';

List<Map> _categories = [
  {
    'name': 'Ayurvdea',
    'image':
        'https://akm-img-a-in.tosshub.com/sites/lovesutras/images/stories/ayurveda-750_042418041256.jpg',
  },
  {
    'name': 'Homepathy',
    'image':
        'https://i.ndtvimg.com/i/2016-10/homeopathic-medicine_650x400_61475418718.jpg',
  },
  {
    'name': 'Halopathy',
    'image':
        'https://5.imimg.com/data5/OI/HJ/MY-35615337/diabetes-allopathic-medicine-500x500.jpg',
  },
  {
    'name': 'Naturopathy',
    'image': 'http://www.naturovillespa.com/images/naturoville-naturopathy.jpg',
  }
];

class ArticlesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Articles',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Container(
              height: 190.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List<Widget>.generate(
                  _categories.length,
                  (index) {
                    return Card(
                      child: Container(
                          width: 120.0,
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                _categories[index]['image'],
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                                alignment: Alignment.center,
                              ),
                              Spacer(),
                              Text(
                                _categories[index]['name'],
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Spacer(),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ),
      ],
    );
  }
}