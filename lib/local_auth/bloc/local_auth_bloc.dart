import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc() : super(LocalAuthState.initial()) {
    on<CheckIfDeviceIsSupportedEvent>(_onCheckIfDeviceIsSupportedEvent);
    on<CheckBiometricsEvent>(_onCheckBiometricsEvent);
    on<GetAvailbableBiometricsEvent>(_onGetAvailableBiometricsEvent);
    on<AuthenticateEvent>(_onAuthenticateEvent);
    on<AuthenticateBiometricsOnlyEvent>(_onAuthenticateBiometricsOnlyEvent);
    on<CancelAuthenticationEvent>(_onCancelAuthenticationEvent);
  }
  Future<void> _onCheckIfDeviceIsSupportedEvent(
    CheckIfDeviceIsSupportedEvent event,
    Emitter<LocalAuthState> emit,
  ) async {
    await state.auth.isDeviceSupported().then((value) {
      if (value) {
        emit(state.copyWith(supportState: SupportState.supported));
      } else {
        emit(state.copyWith(supportState: SupportState.unsupported));
      }
    });
  }

  Future<void> _onCheckBiometricsEvent(
    CheckBiometricsEvent event,
    Emitter<LocalAuthState> emit,
  ) async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await state.auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
    }
    emit(state.copyWith(canCheckBiometrics: canCheckBiometrics));
  }

  Future<void> _onGetAvailableBiometricsEvent(
    GetAvailbableBiometricsEvent event,
    Emitter<LocalAuthState> emit,
  ) async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await state.auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
    }
    emit(state.copyWith(availableBiometrics: availableBiometrics));
  }

  Future<void> _onAuthenticateEvent(
    AuthenticateEvent event,
    Emitter<LocalAuthState> emit,
  ) async {
    bool authenticated = false;

    try {
      emit(
        state.copyWith(
          isAuthenticating: true,
          authorized: 'Authenticating...',
        ),
      );
      authenticated = await state.auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      emit(
        state.copyWith(
          isAuthenticating: false,
        ),
      );
    } on PlatformException catch (e) {
      emit(state.copyWith(
          isAuthenticating: false, authorized: 'Error -${e.toString()}'));
      return;
    }
    emit(state.copyWith(
        authorized: authenticated ? 'Authorized' : 'Not Authorized'));
  }

  Future<void> _onAuthenticateBiometricsOnlyEvent(
    AuthenticateBiometricsOnlyEvent event,
    Emitter<LocalAuthState> emit,
  ) async {
    bool authenticated = false;

    try {
      emit(
        state.copyWith(
          isAuthenticating: true,
          authorized: 'Authenticating...',
        ),
      );
      authenticated = await state.auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      emit(
        state.copyWith(
          isAuthenticating: false,
        ),
      );
    } on PlatformException catch (e) {
      emit(state.copyWith(
          isAuthenticating: false, authorized: 'Error -${e.toString()}'));
      return;
    }
    emit(state.copyWith(
        authorized: authenticated ? 'Authorized' : 'Not Authorized'));
  }

  Future<void> _onCancelAuthenticationEvent(
    CancelAuthenticationEvent event,
    Emitter<LocalAuthState> emit,
  ) async {
    await state.auth.stopAuthentication();

    emit(state.copyWith(
      isAuthenticating: false,
    ));
  }
}
