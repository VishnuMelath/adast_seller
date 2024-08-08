import 'dart:developer';

import 'package:adast_seller/features/drawer/UI/drawer.dart';
import 'package:adast_seller/features/drawer/bloc/drawer_bloc.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login_screen/UI/login_screen.dart';
import '../bloc/splashscreen_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashscreenBloc splashscreenBloc = SplashscreenBloc();
  @override
  void initState() {
    splashscreenBloc.add(SplashLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashscreenBloc, SplashscreenState>(
        bloc: splashscreenBloc,
        builder: (context, state) {
           return Center(
                child: Image.asset('assets/images/logo.png'),
              );
        },
        listener: (context, state) {
          if (state is SplashNavigateToHomeState) {
            log(state.sellerModel.toString());
            context.read<LoginBloc>().sellerModel=state.sellerModel;
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> BlocProvider(
              create: (context) => DrawerBloc(),
              child: const DrawerPage(),
            ),));
          } else if (state.runtimeType == SplashNavigatetoLoginState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          }
        },
      ),
    );
  }
}
