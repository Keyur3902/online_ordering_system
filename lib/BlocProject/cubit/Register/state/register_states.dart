abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegistrationFailedState extends RegisterState {}

class RegistrationVerificationState extends RegisterState {
}