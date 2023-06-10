import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static late Database db;
  static initdb() async {
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/db.db";

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Copy from asset
      ByteData data = await rootBundle.load(("assets/db.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

// open the database
    db = await openDatabase(path, readOnly: true);
    String creat = '''CREATE TABLE "medication" (
	"name"	TEXT,
	"description"	TEXT,
	"indication"	TEXT,
	"mechanism_of_action"	TEXT,
	"toxicity"	TEXT,
	"NOMDEMARQUE"	TEXT,
	"FORME"	TEXT,
	"DOSAGE"	TEXT,
	"COND"	TEXT,
	"LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT"	TEXT,
	"PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT"	TEXT,
	"id"	INTEGER,
	PRIMARY KEY("id")
)
    )''';
    print((await db.query('medication')).length);
  }

  static Future<Iterable<String>> getColumns() async {
    return (await db.query('medication')).first.keys;
  }

  static query() async {
    return (await db.query('medication'));
  }

  static filter(String column, String word) async {
    return (await db.query('medication', where: ''' 
  $column LIKE '%$word%' COLLATE NOCASE'''));
  }
}
