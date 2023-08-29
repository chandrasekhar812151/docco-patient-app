import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MedicalReport extends StatefulWidget {
  final File imageFile;
  final Function callback;

  MedicalReport(this.imageFile, this.callback);

  @override
  MedicalReportState createState() {
    return new MedicalReportState();
  }
}

class MedicalReportState extends State<MedicalReport> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showBottomSheetForImage,
      child: Container(
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey)),
          // ignore: unnecessary_null_comparison
          child: widget.imageFile == null
              ? Icon(
                  Icons.camera_alt,
                  color: Colors.orange,
                  size: 50,
                )
              : Image.file(widget.imageFile)),
    );
  }

  void showBottomSheetForImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(          
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
    widget.callback(null);
  }

  Future getImage(source) async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(
      source: source,
      maxWidth: 1024
    );
    widget.callback(image);
  }
}
