// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:test/local_auth/local_auth.dart';
import 'package:test/pdf/pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalAuthentication auth = LocalAuthentication();
  // _SupportState _supportState = _SupportState.unknown;

  @override
  void initState() {
    super.initState();
    // auth.isDeviceSupported().then(
    //       (bool isSupported) => setState(() => _supportState = isSupported
    //           ? _SupportState.supported
    //           : _SupportState.unsupported),
    //     );
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LocalAuthBloc()..add(CheckIfDeviceIsSupportedEvent()),
        ),
        BlocProvider(
          create: (context) => PdfBloc(),
        ),
      ],
      child: MaterialApp(
          home: PageView(
        children: const [LocalAuthView(), PdfView()],
      )),
    );
  }
}

// enum _SupportState {
//   unknown,
//   supported,
//   unsupported,
// }
