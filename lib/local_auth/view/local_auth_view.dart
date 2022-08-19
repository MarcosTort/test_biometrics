import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../local_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalAuthView extends StatelessWidget {
  const LocalAuthView({Key? key}) : super(key: key);
  




  @override
  Widget build(BuildContext context) {
    final LocalAuthentication auth = LocalAuthentication();
    Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
  }
    return BlocConsumer<LocalAuthBloc, LocalAuthState>(
      listenWhen: (previous, current) => current.status == LocalAuthStatus.error,
      listener: (BuildContext context, LocalAuthState state) {
        if (state.status == LocalAuthStatus.error) {
          //handel error
        }
      },
      buildWhen: (previous, current) => current.status != previous.status,
      builder: (BuildContext context, LocalAuthState state) {
        if(state.status == LocalAuthStatus.initial){
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
            );;
        }
        return Container();
      },
    );
  }
  
}  