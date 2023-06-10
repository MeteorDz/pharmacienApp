import 'dart:developer';

import 'package:flutter/material.dart';

import 'dbhelper.dart';
import 'medWidget.dart';
import 'model.dart';

class ResultScreen extends StatelessWidget {
  final String text;
  final DbHelper db;
  const ResultScreen({super.key, required this.text, required this.db});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: GestureDetector(
              onTap: () {
                search(context, text);
              },
              child: Text(text)),
        ),
      );

  Future<String> search(BuildContext context, String text) async { 
    String col = 'NOMDEMARQUE';
    MedicationModel? med;

    for (var word in text.split('\n')) {
      List<Map<String, Object?>>? mapedMedicationModel =
          (await db.filter(col, word));
      if (mapedMedicationModel != null && mapedMedicationModel.isNotEmpty) {
        med = MedicationModel.fromMap(mapedMedicationModel.first);
      }
      break;
    }

    if (med == null) {
      col = 'name';
      for (var word in text.split('\n')) {
        List<Map<String, Object?>>? mapedMedicationModel =
            (await db.filter(col, word));
        if (mapedMedicationModel != null && mapedMedicationModel.isNotEmpty) {
          med = MedicationModel.fromMap(mapedMedicationModel.first);
        }
        break;
      }
    }
    if (med == null) {
      log('no data');
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MedicationPage(
                    medicationModel: med!,
                  )));
    }
    log(med.toString()); 

    return med.toString();
  }
}
