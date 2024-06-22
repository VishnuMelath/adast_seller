
import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../add_update_item/UI/widgets/custom_textfield.dart';
import '../bloc/login_bloc.dart';

Future forgotPasswordDialog(BuildContext context,
    TextEditingController controller, LoginBloc loginBloc) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Forgot Password'),
        content:
            CustomTextfield(label: 'Email Address', controller: controller),
        actions: [
          CustomButton(onTap: () {
            if(controller.text.isEmpty)
            {
              log('email connot be empty');
            }else
            {
              loginBloc.add(LoginForgotPasswordEvent(email: controller));
            }
            
          }, text: 'Next'),
         
        ],
      );
    },
  );
}
