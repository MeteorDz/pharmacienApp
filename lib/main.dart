import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqlitedatabase/dbhelper.dart';
import 'package:sqlitedatabase/model.dart';
import 'package:sqlitedatabase/remain.dart';

import 'medWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sqldb',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'فرمسيــــان'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
    DbHelper.initdb();
    update();
    super.initState();
  }

  update() async {
    // await DbHelper.initdb();
    // <List<Map<String, Object?>>>
    dataSet = (await DbHelper.query());
    dataSet = dataSet!.where((element) => element['id'] as int < 50).toList();
    columns = (await DbHelper.getColumns()).toList();
    _counter++;
  }

  filter(String column, String word) async {
    // await DbHelper.initdb();
    // <List<Map<String, Object?>>>
    dataSet = (await DbHelper.filter(column, word));
    log(dataSet!.length.toString());
    setState(() {
      dataSet = dataSet!
          .getRange(0, (dataSet!.length < 100 ? dataSet!.length : 100))
          .toList();
      log(dataSet!.length.toString());
    });

    columns = (await DbHelper.getColumns()).toList();
    _counter++;
  }

  Future<void> _incrementCounter() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const App()));
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
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...dataSet
                .map((rows) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MedicationPage(
                                    medicationModel:
                                        MedicationModel.fromMap(rows),
                                  )));
                    },
                    child: Text(rows.values.first.toString())))
                .toList(),
          ]);
    } else {
      return const SizedBox();
    }
  }
}
