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
    return BlocProvider(
      create: (context) => LocalAuthBloc()..add(CheckIfDeviceIsSupportedEvent()),
      child: MaterialApp(
        home: BlocBuilder<LocalAuthBloc, LocalAuthState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Plugin example app'),
              ),
              body: ListView(
                padding: const EdgeInsets.only(top: 30),
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (state.supportState == SupportState.unknown)
                        const CircularProgressIndicator()
                      else if (state.supportState == SupportState.supported)
                        const Text('This device is supported')
                      else
                        const Text('This device is not supported'),
                      const Divider(height: 100),
                      Text('Can check biometrics: ${state.canCheckBiometrics}\n'),
                      ElevatedButton(
                        onPressed: () => context
                            .read<LocalAuthBloc>()
                            .add(CheckBiometricsEvent()),
                        child: const Text('Check biometrics'),
                      ),
                      const Divider(height: 100),
                      Text('Available biometrics: ${state.availableBiometrics}\n'),
                      ElevatedButton(
                        onPressed:() => context.read<LocalAuthBloc>().add(GetAvailbableBiometricsEvent()),
                        child: const Text('Get available biometrics'),
                      ),
                      const Divider(height: 100),
                      Text('Current State: \n'),
                      if (state.isAuthenticating)
                        ElevatedButton(
                          onPressed: _cancelAuthentication,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text('Cancel Authentication'),
                              Icon(Icons.cancel),
                            ],
                          ),
                        )
                      else
                        Column(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: (() => context
                                  .read<LocalAuthBloc>()
                                  .add(AuthenticateEvent())),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Text('Authenticate'),
                                  Icon(Icons.perm_device_information),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<LocalAuthBloc>()
                                  .add(AuthenticateBiometricsOnlyEvent()),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(state.isAuthenticating
                                      ? 'Cancel'
                                      : 'Authenticate: biometrics only'),
                                  const Icon(Icons.fingerprint),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// enum _SupportState {
//   unknown,
//   supported,
//   unsupported,
// }
