import 'dbhelper.dart';
import 'medWidget.dart';
import 'model.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class ResultScreen extends StatefulWidget {
  const ResultScreen(
      {super.key, required this.text, required this.picture, required this.db});

  final String text, picture;
  final DbHelper db;
  @override
  State<ResultScreen> createState() => _ResultScreentState();
}

class _ResultScreentState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    search(context, widget.text);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: GestureDetector(onTap: () {}, child: Text(widget.text)),
        ),
      );

  Future<String> search(BuildContext context, String text) async {
    String col = 'NOMDEMARQUE';
    MedicationModel? med;

    for (var word in text.split('\n')) {
      log(name: 'text$col', word);
      List<Map<String, Object?>>? mapedMedicationModel =
          (await widget.db.filter(col, word));
      if (mapedMedicationModel != null && mapedMedicationModel.isNotEmpty) {
        med = MedicationModel.fromMap(mapedMedicationModel.first);

        break;
      }
    }

    if (med == null) {
      col = 'name';
      for (var word in text.split('\n')) {
        log(name: 'text$col', word);
        List<Map<String, Object?>>? mapedMedicationModel =
            (await widget.db.filter(col, word));
        if (mapedMedicationModel != null && mapedMedicationModel.isNotEmpty) {
          med = MedicationModel.fromMap(mapedMedicationModel.first);
          break;
        }
      }
    }
    if (med == null) {
      log('no data');
    } else {
      med = med.copyWith(picture: widget.picture);
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
