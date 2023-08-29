// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_patient/uidata.dart';

class ProfilePicture extends StatelessWidget {

  BoxFit? fit;
  double? height;

  ProfilePicture(this.url, {required BoxFit fit, required double height}) {
    this.fit = fit;
    this.height = height;
  }

  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.isNotEmpty) {
      return CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Image.network(
              url,
              fit: BoxFit.cover,
            ),
        imageUrl: url,
        placeholder: (context, url) => Image.asset(
              UIData.userDefaultImage,
              fit: BoxFit.cover,
            ),
        errorWidget: (context, url, error) {
          print('Cannot load image');
          return Icon(Icons.error);
        },
      );
    }

    return Image.asset(
      UIData.userDefaultImage,
      fit: BoxFit.cover,
    );
  }

  static Widget circular(url, {required double radius}) {
    if (url != null) {
      return CachedNetworkImage(
        imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: radius != null ? radius : 20,
              backgroundImage: imageProvider,
            ),
        imageUrl: url,
        placeholder: (context, url) => CircleAvatar(
              radius: radius != null ? radius : 20,
              backgroundImage: AssetImage(UIData.userDefaultImage),
            ),
        errorWidget: (context, url, error) {
          print('Cannot load image');
          return Icon(Icons.error);
        },
      );
    }

    return CircleAvatar(
      radius: radius != null ? radius : 20,
      backgroundImage: AssetImage(UIData.userDefaultImage),
    );
  }

  static Widget circularFromFile(file, {required double radius}) {
    return CircleAvatar(
      radius: radius != null ? radius : 20,
      backgroundImage: FileImage(file),
    );
  }
}
