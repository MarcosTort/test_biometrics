import 'package:flutter/material.dart';
import '../local_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalAuthView extends StatelessWidget {
  const LocalAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          return Container();
        }
        return Container();
      },
    );
  }
}