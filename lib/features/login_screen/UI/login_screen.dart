
import 'package:adast_seller/features/drawer/UI/drawer.dart';
import 'package:adast_seller/features/login_screen/UI/forgot_password.dart';
import 'package:adast_seller/features/map/UI/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ themes/colors_shemes.dart';
import '../../../ themes/themes.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_snackbar.dart';
import '../../../custom_widgets/custom_textfield.dart';
import '../../register_page.dart/UI/register_page.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

 late LoginBloc loginBloc ;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController emailcontroller1 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    loginBloc=context.read<LoginBloc>();
    return Scaffold(
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: BlocListener<LoginBloc, LoginState>(
            bloc: loginBloc,
            listener: (context, state) {
              if (state is LoginEmptyFieldState) {
                customSnackBar(context, 'email and password cannot be empty');
              }
              if (state is LoginInvalidUserIdOrPassState) {
                customSnackBar(context, 'invalid email or password');
              }
              if (state is LoginNavigateToHomeState) {
                context.read<LoginBloc>().sellerModel=state.sellerModel;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const DrawerPage(),));

              }
              if (state is LoginNavigateToCompleteProfileState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapScreen()));
              }
              if (state is LoginNavigateToRegisterState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ));
              }
              if (state is
                  LoginForgotPassMailSuccesfullySentState) {
                customSnackBar(context,
                    'Password reset mail successfully sent to your mail address');
                Navigator.pop(context);
                emailcontroller.clear();
              }
            },
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.04),
                  child: Center(
                      child: Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                  )),
                ),
                CustomTextfield(
                  label: 'Email Address',
                  controller: emailcontroller,
                  login: true,
                ),
                CustomTextfield(
                  label: 'Password',
                  controller: passwordController,
                  password: true,
                  login: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                        onTap: () {
                          forgotPasswordDialog(
                              context, emailcontroller1, loginBloc);
                          //todo : forgot password
                        },
                        child: const Text(
                          'forgot password?',
                          style: TextStyle(
                            color: green,
                            fontSize: 13,
                          ),
                        )),
                  ),
                ),
                CustomButton(
                  onTap: () {
                    loginBloc.add(LoginButtonPressedEvent(
                        email: emailcontroller, pass: passwordController));
                    //todo login button action
                  },
                  text: 'Login',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: const Row(
                    children: [
                      Expanded(child: Divider()),
                      Text('  or sign up with  '),
                      Expanded(child: Divider()),
                    ],
                  ),
                ),
                CustomButton(
                  onTap: () {
                    loginBloc.add(LoginGoogleAuthPressedEvent());
                    //todo validation google
                  },
                  text: 'Google',
                  icon: true,
                ),
                Center(
                  child: BlocListener(
                    bloc: LoginBloc(),
                    listener: (context, state) {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Don\'t have an Account?'),
                        GestureDetector(
                          onTap: () {
                            loginBloc.add(LoginRegisterPressedEvent());
                            //todo : register
                          },
                          child: const Text(
                            'Sign up here',
                            style: greenTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
