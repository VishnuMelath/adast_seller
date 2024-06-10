import 'dart:async';
import 'dart:developer';

import 'package:adast_seller/models/seller_model.dart';
import 'package:adast_seller/services/user_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../services/auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  SellerModel? sellerModel;
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressedEvent>(loginButtonPressedEvent);
    on<LoginRegisterPressedEvent>(loginRegisterPressedEvent);
    on<LoginGoogleAuthPressedEvent>(loginGoogleAuthPressedEvent);
    on<LoginForgotPasswordEvent>(loginForgotPasswordEvent);
  }

  FutureOr<void> loginButtonPressedEvent(
      LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    if (event.email.text.isEmpty || event.pass.text.isEmpty) {
      emit(LoginEmptyFieldState());
    } else {
      await LoginService()
          .signInWithMailandPass(event.email.text, event.pass.text);
      emit(LoginNavigateToHomeState());
    }
  }

  FutureOr<void> loginRegisterPressedEvent(
      LoginRegisterPressedEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToRegisterState());
  }

  FutureOr<void> loginGoogleAuthPressedEvent(
      LoginGoogleAuthPressedEvent event, Emitter<LoginState> emit) async {
    var result = await LoginService().signUpWithGoogle();
    log(result.toString());
    if (!result.$2) {
      sellerModel = await DatabaseServices().getSellerData(result.$1!);
      emit(LoginNavigateToHomeState());
    } else {
      sellerModel = SellerModel(email: result.$1!, name: '');
      emit(LoginNavigateToCompleteProfileState());
    }
  }

  FutureOr<void> loginForgotPasswordEvent(
      LoginForgotPasswordEvent event, Emitter<LoginState> emit) async {
    await LoginService().resetPassword(event.email.text);
    emit(LoginForgotPassMailSuccesfullySentState());
  }
}
