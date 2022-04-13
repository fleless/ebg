import 'dart:io';

import 'package:ebg/models/fichesModel.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

class ViewFileBloc extends Disposable {
  late FichesModel fiche;

  Future<pw.Document> createPdfFile() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Center(
              child: pw.Text("Fiche EBG"),
            ),
            pw.SizedBox(height: 60),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: Text(fiche.nomPrenom! +
                  ", " +
                  fiche.poste! +
                  ", " +
                  fiche.entreprise!),
            ),
            pw.SizedBox(height: 30),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: Text(fiche.description!),
            ),
            pw.SizedBox(height: 30),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: Text("Types de besoins : "),
            ),
            pw.SizedBox(height: 10),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  spacing: 20.0,
                  runSpacing: 10.0,
                  direction: Axis.horizontal,
                  children: [
                    for (var items in fiche.getListTypesBesoins())
                      pw.Container(
                        padding: const EdgeInsets.all(10),
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(15),
                          color: PdfColor.fromHex("#003B73"),
                        ),
                        child: Text(items.trim(),
                            style: pw.TextStyle(
                                color: PdfColor.fromHex("#FFFFFF"))),
                      ),
                  ]),
            ),
            pw.SizedBox(height: 30),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: Text("Compétences : "),
            ),
            pw.SizedBox(height: 10),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  spacing: 20.0,
                  runSpacing: 10.0,
                  direction: Axis.horizontal,
                  children: [
                    for (var items in fiche.getListCompentences())
                      pw.Container(
                        padding: const EdgeInsets.all(10),
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(15),
                          color: PdfColor.fromHex("#003B73"),
                        ),
                        child: Text(items.trim(),
                            style: pw.TextStyle(
                                color: PdfColor.fromHex("#FFFFFF"))),
                      ),
                  ]),
            ),
          ]); // Center
        }));
    return pdf;
  }

  downloadPdf() async {
    Document pdf = await createPdfFile();
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/Fiche_${fiche.nomPrenom}.pdf');
    await file.writeAsBytes(await pdf.save());
    final status = await Permission.storage.request();
    if (status.isGranted) {
      openFile(file: file);
    } else {
      print("permission denied");
    }
  }

  Future openFile({File? file}) async {
    OpenFile.open(file!.path);
  }

  partagerPdf() async {
    Document pdf = await createPdfFile();
    await Printing.sharePdf(
        bytes: await pdf.save(), filename: 'Fiche_${fiche.nomPrenom}.pdf');
  }

  @override
  dispose() {}
}
