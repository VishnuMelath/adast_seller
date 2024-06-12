part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

sealed class LoginActionState extends LoginState{}

final class LoginInitial extends LoginState {}

class LoginEmptyFieldState extends LoginActionState{}

class LoginButtonPressedState extends LoginState{}

 class LoginNavigateToHomeState extends LoginActionState{
  final SellerModel sellerModel;

  LoginNavigateToHomeState({required this.sellerModel});

 }

 class LoginNavigateToRegisterState extends LoginActionState{}

 class LoginInvalidUserIdOrPassState extends LoginActionState{}

 class LoginGoogleAuthenticationState extends LoginActionState{}

 class LoginForgotPassMailSuccesfullySentState extends LoginActionState{}

 class LoginNavigateToCompleteProfileState extends LoginActionState{}

 class LoginErrorState extends LoginActionState{
  final String message;
  LoginErrorState({required this.message});
 }
 


