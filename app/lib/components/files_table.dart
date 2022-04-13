import 'package:app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FilesTable extends StatefulWidget {
  final List<Item> items;
  const FilesTable({Key? key, required this.items}) : super(key: key);

  @override
  State<FilesTable> createState() => _FilesTableState();
}

class _FilesTableState extends State<FilesTable> {
  @override
  Widget build(BuildContext context) {
    List<TableRow> all = widget.items.map<TableRow>((item) {
      return TableRow(children: [
        TableCell(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 120.0,
              child: Text(
                item.name,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(item.size.toString()),
            Text(item.uploadDate),
            IconButton(
                icon: const Icon(Icons.download),
                onPressed: () async {
                  try {
                    await launch(item.url);
                  } catch (e) {
                    print(e);
                  }
                }),
          ],
        ))
      ]);
    }).toList();

    TableRow tableHeader = TableRow(children: [
      TableCell(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const <Widget>[
          Text("Name"),
          Text("Size(Byte)"),
          Text("Upload Date"),
          Text("Download")
        ],
      ))
    ]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Uploaded Files",
          style: TextStyle(
            fontFamily: "EmilysCandy",
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 8.0)),
        Table(
          border: TableBorder.all(width: 1.0, color: Colors.black),
          children: [tableHeader, ...all],
        )
      ],
    );
  }
}
