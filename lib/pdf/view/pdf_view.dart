import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/pdf/model.dart';
import 'package:test/pdf/pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfView extends StatelessWidget {
  const PdfView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pdfexample = pw.Document();

    return BlocConsumer<PdfBloc, PdfState>(
      listenWhen: (previous, current) => current.status == PdfStatus.error,
      listener: (BuildContext context, PdfState state) {
        if (state.status == PdfStatus.error) {
          //handel error
        }
      },
      buildWhen: (previous, current) => current.status != previous.status,
      builder: (BuildContext context, PdfState state) {
        if (state.status == PdfStatus.initial) {
          return Scaffold(
            body: ListView(
              children: [
                ...invoices.map((e) => ListTile(
                      title: Text(e.name ?? ''),
                      subtitle: Text(e.customer ?? ' '),
                      trailing: Text('\$${e.totalCost().toStringAsFixed(2)}'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => DetailPage(invoice: e),
                          ),
                        );
                      },
                    ))
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  final Invoice invoice;
  const DetailPage({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfPreviewPage(invoice: invoice),
            ),
          );
          // rootBundle.
        },
        child: Icon(Icons.picture_as_pdf),
      ),
      appBar: AppBar(
        title: Text(invoice.name ?? "name"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Customer',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      invoice.customer ?? "customer",
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Column(
                children: [
                  Text(
                    'Invoice Items',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  ...invoice.items!.map(
                    (e) => ListTile(
                      title: Text(e.description),
                      trailing: Text(
                        e.cost.toStringAsFixed(2),
                      ),
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.headline4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Total"),
                        Text(
                          invoice.totalCost().toStringAsFixed(2),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PdfPreviewPage extends StatelessWidget {
  final Invoice invoice;
  const PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice),
        allowPrinting: false,
        allowSharing: true,
        canChangeOrientation: false,
        canChangePageFormat: false,
      
      ),
    );
  }
}

Future<Uint8List> makePdf(Invoice invoice) async {
  final pdf = pw.Document();
  final image = await rootBundle.load('lib/assets/logo.png');

  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4.copyWith(marginLeft: 0, marginRight: 0),
    header: (context) {
      return pw.Column(children: [
        pw.Image(
          pw.MemoryImage(image.buffer.asUint8List()),
          width: 200,
        ),
        pw.Divider(color: PdfColor.fromHex('#000000'), thickness: 5),
      ]);
      // pw.Divider(color: PdfColor.fromHex('#000000'), thickness: 5),
    },
    build: (context) {
      return [
        pw.Padding(
            padding: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: pw.Center(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                  pw.SizedBox(height: 20),
                  pw.Text('Card Activity from Jun 23, 2022 to Aug 22, 2022'),
                  pw.SizedBox(height: 20),
                  pw.Container(
                      color: PdfColor.fromHex('#0c6ab8'),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          ' Transaction id',
                          ' Date',
                          ' Description',
                          ' Amount',
                          ' Fee',
                          ' Time',
                          ' Reference Information            ',
                        ]
                            .map((e) => pw.Row(children: [
                                  pw.Container(
                                    width: 0.5,
                                    height: 15,
                                    color: PdfColors.white,
                                  ),
                                  pw.Text(
                                    e,
                                    style: pw.TextStyle(
                                      color: PdfColors.white,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ]))
                            .toList(),
                      )),
                  pw.Container(
                      color: PdfColors.grey300,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          ' Transaction id',
                          ' Date',
                          ' Description',
                          ' Amount',
                          ' Fee',
                          ' Time',
                          ' Reference Information            ',
                        ]
                            .map((e) => pw.Row(children: [
                                  pw.Text(
                                    e,
                                    style: pw.TextStyle(
                                      color: PdfColors.grey700,
                                      fontWeight: pw.FontWeight.normal,
                                    ),
                                  ),
                                ]))
                            .toList(),
                      )),
                ],
                //color: PdfColor.fromHex('#5f5fce'),
              ),
            ))
      ];
    },
  ));
  return pdf.save();
}
