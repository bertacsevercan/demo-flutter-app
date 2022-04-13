import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'File Uploader';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      title: _title,
    );
  }
}
