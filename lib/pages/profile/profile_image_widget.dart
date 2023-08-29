import 'dart:io';

import 'package:doctor_patient/models/profile.dart';
import 'package:doctor_patient/pages/image_full_view.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:doctor_patient/widgets/profile_picture.dart';
import 'package:doctor_patient/docco_exception.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageWidget extends StatefulWidget {
  final Profile data;

  ProfileImageWidget(this.data);

  @override
  ProfileImageWidgetState createState() {
    return new ProfileImageWidgetState();
  }
}

class ProfileImageWidgetState extends State<ProfileImageWidget> {
  File? _image;

  Widget _buildImage() {
    if (_image != null) {
      return ProfilePicture.circularFromFile(_image, radius: 72);
    }
    return GestureDetector(
      onTap: () {
        if (widget.data.avatar != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImageFullView(widget.data.avatar.toString())));
        }
      },
      child: ProfilePicture.circular(widget.data.avatar, radius: 72),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          _buildImage(),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: UIData.primaryColor,
              child: InkResponse(
                borderRadius: BorderRadius.circular(20.0),
                highlightShape: BoxShape.rectangle,
                containedInkWell: true,
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    // color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                splashColor: Colors.white24,
                onTap: () {
                  showBottomSheetForImage();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  showBottomSheetForImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete picture'),
                onTap: () async {
                  print('deleting picture');
                  Navigator.pop(context);
                  await _deleteProfilePic();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future _deleteProfilePic() async {
    if (widget.data.avatar == null) {
      print('picture is null');
      return;
    }

    _showCustomProgressDialog('Deleting...');
    try {
      await Repository.deleteProfilePic();
      setState(() {
        widget.data.avatar = null;
        _image = null;
      });

      Navigator.pop(context);
    } on DoccoException catch (e) {
      print(e);
      print(e.getMessage());
      print(e.getCode());
    } catch (e) {
      print(e);
    }
  }

  Future getImage(source) async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(
      source: source,
      maxWidth: 600,
    );

    if (image == null) {
      return;
    }

    _showCustomProgressDialog('Updating...');

    try {
      print('updating profile');
      var url = await Repository.updateProfilePic(image);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('avatar', url);
      setState(() {
        _image = image as File?;
        widget.data.avatar = url;
      });
      Navigator.pop(context);
    } on DoccoException catch (e) {
      print(e);
      print(e.getMessage());
      print(e.getCode());
    } catch (e) {
      print(e);
    }
  }

  void _showCustomProgressDialog(String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
            child: Container(
                padding: EdgeInsets.all(32),
                child: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(width: 16),
                    Text('Updating...'),
                  ],
                )),
          ),
    );
  }
}
