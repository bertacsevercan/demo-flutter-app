import 'package:app/services/api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadArea extends StatefulWidget {
  final Function updateView;

  const UploadArea({Key? key, required this.updateView}) : super(key: key);

  @override
  State<UploadArea> createState() => _UploadAreaState();
}

class _UploadAreaState extends State<UploadArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Upload a file",
              style: TextStyle(
                fontFamily: "EmilysCandy",
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 8.0)),
            ElevatedButton(
              child: const Icon(Icons.upload),
              onPressed: () => _pickFiles(),
            ),
          ],
        ),
      ],
    );
  }

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      var _path = result.files.single.path;
      Api api = Api();
      await api.uploadFile(_path);
      widget.updateView();
      print("File uploaded!");
    } else {
      // User canceled the picker
    }
  }
}
