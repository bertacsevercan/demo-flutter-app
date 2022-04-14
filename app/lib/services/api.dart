import 'package:app/models/item.dart';
import "package:http/http.dart";
import 'dart:convert';
import 'package:intl/intl.dart';

class Api {
  List<Item> files = [
    Item(name: "n/a", size: 0, url: "n/a", uploadDate: "n/a")
  ];
  String url = "http://localhost:5000/items";

  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };

  Future<void> uploadFile(filePath) async {
    try {
      var req = MultipartRequest('POST', Uri.parse(url));
      var value = await MultipartFile.fromPath("file", filePath);
      req.files.add(value);
      var res = await req.send();
      print(res);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List> getFiles() async {
    try {
      print("Getting data...");
      Response response = await get(Uri.parse(url), headers: headers);
      List data = jsonDecode(response.body);
      files = data.map((e) {
        return Item(
            name: e["name"],
            size: e["size"],
            url: e["url"],
            uploadDate: convertDateTime(e["dateUpload"]));
      }).toList();
      return files;
    } catch (e) {
      print("Error: $e");
      return files;
    }
  }

  String convertDateTime(dateTime) {
    String _dateTime = dateTime.toString();
    String offset = _dateTime.split("+")[1].substring(1, 2);
    DateTime now = DateTime.parse(_dateTime);
    now = now.add(Duration(hours: int.parse(offset)));
    String formatted = DateFormat.yMd().add_jm().format(now);
    return formatted;
  }
}
