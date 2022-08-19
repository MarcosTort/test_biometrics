part of 'local_auth_bloc.dart';

abstract class LocalAuthEvent extends Equatable {
  const LocalAuthEvent();
}

class CheckIfDeviceIsSupportedEvent extends LocalAuthEvent{
  @override
  List<Object> get props => [];
}

class CheckBiometricsEvent extends LocalAuthEvent{
  @override
  List<Object> get props => [];
}
class GetAvailbableBiometricsEvent extends LocalAuthEvent{
  @override
  List<Object> get props => [];
}
class AuthenticateEvent extends LocalAuthEvent{
  @override
  List<Object> get props => [];
}
class AuthenticateBiometricsOnlyEvent extends LocalAuthEvent{
  @override
  List<Object> get props => [];
}

class CancelAuthenticationEvent extends LocalAuthEvent{
  @override
  List<Object> get props => [];
}