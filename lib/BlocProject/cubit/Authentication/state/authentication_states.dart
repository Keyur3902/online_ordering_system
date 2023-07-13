abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {}

class AuthenticationFailedState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class ResendOtpState extends AuthenticationState {}