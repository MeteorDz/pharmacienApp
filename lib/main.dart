import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqlitedatabase/model.dart';
import 'package:sqlitedatabase/scanner.dart';

import 'dbhelper.dart';
import 'medWidget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final DbHelper db = DbHelper();
  db.initdb();
  runApp(MyApp(
    db: db,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.db});
  final DbHelper db;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sqldb',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(db: db, title: 'فرمسيــــان'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.db});
  final DbHelper db;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Map<String, Object?>>? dataSet;
  List<String>? columns;
  @override
  void initState() {
    DbHelper().initdb().then((value) => update());

    super.initState();
  }

  update() async {
    dataSet = (await widget.db.query());
    dataSet = dataSet!.where((element) => element['id'] as int < 50).toList();
    columns = (await widget.db.getColumns()).toList();
    _counter++;
  }

  filter(String column, String word) async {
    // await db.initdb();
    // <List<Map<String, Object?>>>
    String col = 'NOMDEMARQUE';

    dataSet = (await widget.db.filter(col, word));
    if (dataSet == null || dataSet!.isEmpty) {
      col = 'name';
      dataSet = (await widget.db.filter(col, word));
    }

    setState(() {
      dataSet = dataSet!
          .getRange(0, (dataSet!.length < 100 ? dataSet!.length : 100))
          .toList();
      log(dataSet!.length.toString());
    });

    columns = (await widget.db.getColumns()).toList();
    _counter++;
  }

  Future<void> _incrementCounter() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => App(
                  db: widget.db,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    filter('name', value);
                  });
                },
              ),
              Expanded(child: SingleChildScrollView(child: getTable(dataSet))),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: _counter.toString(),
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }

  getTable(
    List<Map<String, Object?>>? dataSet,
  ) {
    if (dataSet != null) {
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        ...dataSet
            .map((rows) => SizedBox(
              width: double.infinity, 
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicationPage(
                                      medicationModel:
                                          MedicationModel.fromMap(rows),
                                    )));
                      },
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          Text(rows.values.toList()[5].toString()),
                          Text(rows.values.toList()[0].toString()),
                          Text(rows.values.toList()[7].toString()),
                        ],
                      )),
                ))
            .toList(),
      ]);
    } else {
      return const SizedBox();
    }
  }
}
