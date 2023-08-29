import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageFullView extends StatelessWidget {
  final String imageUrl;

  ImageFullView(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Center(
            child: PhotoView(
              maxScale: 2.5,
              minScale: 0.5,
              imageProvider: NetworkImage(imageUrl),
            ),
          ),
        ),
        SafeArea(
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
      ],
    );
  }
}
