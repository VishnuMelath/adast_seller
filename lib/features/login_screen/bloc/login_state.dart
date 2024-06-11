part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

sealed class LoginActionState extends LoginState{}

final class LoginInitial extends LoginState {}

class LoginEmptyFieldState extends LoginActionState{}

 class LoginNavigateToHomeState extends LoginActionState{
  final SellerModel sellerModel;

  LoginNavigateToHomeState({required this.sellerModel});

 }

 class LoginNavigateToRegisterState extends LoginActionState{}

 class LoginInvalidUserIdOrPassState extends LoginActionState{}

 class LoginGoogleAuthenticationState extends LoginActionState{}

 class LoginForgotPassMailSuccesfullySentState extends LoginActionState{}

 class LoginNavigateToCompleteProfileState extends LoginActionState{}
 


