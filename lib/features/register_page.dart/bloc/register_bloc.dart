import 'dart:async';
import 'dart:developer';


import 'package:adast_seller/models/seller_model.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../services/auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonEvent>(registerButtonEvent);
  }

  FutureOr<void> registerButtonEvent(RegisterButtonEvent event, Emitter<RegisterState> emit) async{
    emit(RegisterButtomPressedState());
    var user=SellerModel( name: event.nameController.text, email: event.emailController.text,place: '' );
    if(event.formkey.currentState!.validate())
    {
      try{
       await LoginService().signUp(user, event.passController.text);
        emit(RegisterSuccessState());
      }
      on FirebaseException catch(e)
      {
        log(e.toString());
        emit(RegisterErrorState(errormsg: e.code));
      }
    }
    emit(RegisterButtonDefaultState());

   
  }
}
