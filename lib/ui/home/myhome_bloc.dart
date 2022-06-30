import 'dart:io';

import 'package:ebg/models/fichesModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class HomeBloc extends Disposable {
  List<FichesModel>? listFiches = <FichesModel>[];
  final ref = FirebaseDatabase.instance.ref();
  final listChangesNotifier = PublishSubject<int>();

  getData() async {
    DataSnapshot snapshot = await ref.child('files').get();
    if (snapshot.exists) {
      final map = snapshot.value as Map<dynamic, dynamic>;
      listFiches!.clear();
      map.forEach((key, value) {
        final fiche = FichesModel.fromMap(value);
        listFiches!.add(fiche);
      });
      listChangesNotifier.add(0);
    } else {
      print('No data available.');
    }
  }

  refreshData(DataSnapshot snapshot) {
    if (snapshot.exists) {
      final map = snapshot.value as Map<dynamic, dynamic>;
      listFiches!.clear();
      map.forEach((key, value) {
        final fiche = FichesModel.fromMap(value);
        listFiches!.add(fiche);
      });
      listChangesNotifier.add(0);
    } else {
      print('No data available.');
    }
  }

  exportCSV() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText("Nom prénom");
    sheet.getRangeByName('B1').setText("Poste");
    sheet.getRangeByName('C1').setText("Entreprise");
    sheet.getRangeByName('D1').setText("Description");
    sheet.getRangeByName('E1').setText("Compétences");
    sheet.getRangeByName('F1').setText("Types de besoins");
    int i = 1;
    listFiches!.forEach((element) {
      i++;
      sheet.getRangeByName('A$i').setText(element.nomPrenom);
      sheet.getRangeByName('B$i').setText(element.poste);
      sheet.getRangeByName('C$i').setText(element.entreprise);
      sheet.getRangeByName('D$i').setText(element.description);
      sheet.getRangeByName('E$i').setText(element.competences);
      sheet.getRangeByName('F$i').setText(element.typesBesoins);
    });
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  dispose() {}
}
