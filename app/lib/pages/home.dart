import 'package:app/components/files_table.dart';
import 'package:app/components/upload_area.dart';
import 'package:app/models/item.dart';
import 'package:app/services/api.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List> _futureItems;
  Api api = Api();

  @override
  void initState() {
    super.initState();
    _futureItems = api.getFiles();
  }

  void updateView() {
    return setState(() {
      _futureItems = api.getFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: const Text(
          "Demo App",
          style: TextStyle(
            fontFamily: "EmilysCandy",
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(padding: EdgeInsets.only(top: 8.0)),
            UploadArea(
              updateView: () => updateView(),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            FutureBuilder<List>(
                future: _futureItems,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return FilesTable(
                        items: snapshot.data as List<Item>,
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                })
          ],
        ),
      ),
    );
  }
}
