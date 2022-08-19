import 'dart:typed_data';

import 'package:flutter/material.dart';
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
      ),
    );
  }
}

Future<Uint8List> makePdf(Invoice invoice) async {
  final pdf = pw.Document();
  pdf.addPage(pw.Page(
    build: (context) {
      return pw.Center(
        child: pw.Text('Invoice'),
      );
    },
  ));
  return pdf.save();

}
