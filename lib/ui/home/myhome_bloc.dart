import 'package:ebg/models/fichesModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

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

  dispose() {}
}
