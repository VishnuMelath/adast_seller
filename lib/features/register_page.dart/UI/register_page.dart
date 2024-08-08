import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/features/map/UI/map.dart';
import 'package:adast_seller/models/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ themes/themes.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_snackbar.dart';
import '../../add_update_item/UI/widgets/custom_textfield.dart';
import '../bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc registerBloc = RegisterBloc();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          'REGISTER',
          style: greenTextStyle,
        ),
      ),
      body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: BlocListener<RegisterBloc, RegisterState>(
              bloc: registerBloc,
              listener: (context, state) {
                if (state is RegisterSuccessState) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MapScreen(),
                    ),
                  );
                }
                if (state is RegisterErrorState) {
                  customSnackBar(context, state.errormsg);
                }
              },
              child: ListView(
                children: [
                  CustomTextfield(
                    label: 'email address',
                    controller: emailController,
                    login: false,
                  ),
                  CustomTextfield(
                    label: 'password',
                    controller: passwordController,
                    login: false,
                    password: true,
                  ),
                  CustomTextfield(
                    passController: passwordController,
                    label: 'confirm password',
                    controller: rePasswordController,
                    login: false,
                    password: true,
                  ),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    bloc: registerBloc,
                    builder: (context, state) {
                      if (state is RegisterButtomPressedState) {
                        return CustomButton(
                          onTap: () {},
                          text: 'Submit',
                          loading: true,
                        );
                      } else {
                        return CustomButton(
                            onTap: () {
                              context.read<LoginBloc>().sellerModel=SellerModel(place: '',name: '', email: emailController.text,creationTime: DateTime.now());
                              registerBloc.add(RegisterButtonEvent(
                                  formkey: formkey,
                                  emailController: emailController,
                                  nameController: nameController,
                                  passController: passwordController));
                            },
                            text: 'Next');
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
