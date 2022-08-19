part of 'local_auth_bloc.dart';

enum LocalAuthStatus {
  initial,
  loading,
  loaded,
  error,
}

enum SupportState { unsupported, supported, unknown }

class LocalAuthState extends Equatable {
  const LocalAuthState(
      {required this.status,
      required this.supportState,
      this.canCheckBiometrics,
      this.availableBiometrics,
      required this.authorized,
      required this.isAuthenticating,
      required this.auth});

  LocalAuthState.initial()
      : this(
          status: LocalAuthStatus.initial,
          supportState: SupportState.unknown,
          authorized: 'Not Authorized',
          isAuthenticating: false,
          auth: LocalAuthentication(),
        );

  final LocalAuthStatus status;
  final LocalAuthentication auth; // = LocalAuthentication();
  final SupportState supportState; // = _SupportState.unknown;
  final bool? canCheckBiometrics;
  final List<BiometricType>? availableBiometrics;
  final String authorized; // = 'Not Authorized';
  final bool isAuthenticating; // = false;
  LocalAuthState copyWith({
    LocalAuthStatus? status,
    SupportState? supportState,
    bool? canCheckBiometrics,
    List<BiometricType>? availableBiometrics,
    String? authorized,
    bool? isAuthenticating,
    LocalAuthentication? auth,
  }) {
    return LocalAuthState(
      status: status ?? this.status,
      supportState: supportState ?? this.supportState,
      canCheckBiometrics: canCheckBiometrics ?? this.canCheckBiometrics,
      availableBiometrics: availableBiometrics ?? this.availableBiometrics,
      authorized: authorized ?? this.authorized,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      auth: auth ?? this.auth,
    );
  }

  @override
  List<Object?> get props => [
        status,
        supportState,
        canCheckBiometrics,
        availableBiometrics,
        authorized,
        isAuthenticating,
        auth,
      ];
}
