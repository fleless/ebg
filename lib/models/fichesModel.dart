class FichesModel {
  String? nomPrenom;
  String? poste;
  String? entreprise;
  String? description;
  String? typesBesoins;
  String? competences;

  FichesModel(
      {this.nomPrenom,
      this.poste,
      this.entreprise,
      this.description,
      this.typesBesoins,
      this.competences});

  List<String> getListTypesBesoins() {
    return typesBesoins!.split(',');
  }

  List<String> getListCompentences() {
    return competences!.split(',');
  }

  factory FichesModel.fromMap(Map<dynamic, dynamic> map) {
    return FichesModel(
        nomPrenom: map['nomPrenom'] ?? '',
        poste: map['post'] ?? '',
        entreprise: map['entreprise'] ?? '',
        description: map['description'] ?? '',
        typesBesoins: map['typebesoins'] ?? '',
        competences: map['competences'] ?? '');
  }
}
