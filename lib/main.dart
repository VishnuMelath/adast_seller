import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/features/settings/UI/widgets/test/test.dart';
import 'package:adast_seller/features/splash_screen/UI/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adast Seller',
        theme: ThemeData(
          
          appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: green),systemOverlayStyle: SystemUiOverlayStyle.dark),
          colorScheme: ColorScheme.fromSeed(seedColor: green),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
