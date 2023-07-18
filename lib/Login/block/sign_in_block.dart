import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation_using_bloc/Login/block/sign_in_event.dart';
import 'package:form_validation_using_bloc/Login/block/sign_in_state.dart';

class SignInBlock extends Bloc<SignEvents, SignInState> {
  SignInBlock() : super(SignInInitialState()) {
    on<SignInTextChangeEvent>((event, emit) {
      if (event.passwordValue == "" &&
          EmailValidator.validate(event.emailValue) == false) {
        emit(SignInErrorState(errorMessage: "enter valid email Address"));
      } else if (event.passwordValue.length < 8) {
        emit(SignInErrorState(errorMessage: "Please enter a valid password"));
      } else {
        emit(SignInInvalidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
