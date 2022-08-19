import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../local_auth.dart';

class LocalAuthRoute extends StatelessWidget {
  const LocalAuthRoute({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (ctx) {
        return BlocProvider(
          create: (_) => LocalAuthBloc(),
          child: const LocalAuthView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const LocalAuthView();
  }
}