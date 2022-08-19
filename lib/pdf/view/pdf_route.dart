import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/pdf/pdf.dart';


class PdfRoute extends StatelessWidget {
  const PdfRoute({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (ctx) {
        return BlocProvider(
          create: (_) => PdfBloc(),
          child: const PdfView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const PdfView();
  }
}