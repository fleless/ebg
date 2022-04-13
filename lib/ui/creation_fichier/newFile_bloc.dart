import 'package:ebg/models/fichesModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class NewFileBloc extends Disposable {
  final databaseRef =
      FirebaseDatabase.instance.ref(); //database reference object
  FichesModel newFiche = FichesModel(
      nomPrenom: "",
      entreprise: "",
      poste: "",
      description: "",
      competences: "",
      typesBesoins: "");
  int step = 1;
  final stepChangesNotifier = PublishSubject<int>();
  List<String> listBesoins = <String>[];
  List<String> listCompetences = <String>[];

  changeStep(int number) {
    step = number;
    stepChangesNotifier.add(step);
  }

  resetFile() {
    newFiche = FichesModel(
        nomPrenom: "",
        entreprise: "",
        poste: "",
        description: "",
        competences: "",
        typesBesoins: "");
    listBesoins.clear();
    listCompetences.clear();
  }

  void addFileToFireBaseDB() async {
    databaseRef.child("files").push().set({
      'nomPrenom': newFiche.nomPrenom!.trim(),
      'post': newFiche.poste!.trim(),
      'entreprise': newFiche.entreprise!.trim(),
      'description': newFiche.description!.trim(),
      'typebesoins': getStringFromList(listBesoins),
      'competences': getStringFromList(listCompetences)
    }).asStream();
  }

  String getStringFromList(List<String> lista) {
    return lista.join(',');
  }

  @override
  dispose() {
    stepChangesNotifier.close();
  }
}
