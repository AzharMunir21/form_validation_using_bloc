abstract class SignEvents {}

class SignInTextChangeEvent extends SignEvents {
  final String emailValue;
  final String passwordValue;

  SignInTextChangeEvent({
    required this.emailValue,
    required this.passwordValue,
  });
}

class SignInSubmittedEvent extends SignEvents {
  final String? email;
  final String? password;
  SignInSubmittedEvent({
    this.email,
    this.password,
  });
}
