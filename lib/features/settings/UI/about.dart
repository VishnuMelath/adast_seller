
import 'package:flutter/material.dart';

import '../../../ themes/colors_shemes.dart';
import '../../../ themes/themes.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [ 
                Image.asset('assets/images/logo.png'),
                SizedBox(
                  height: 80,
                  child:  Text('Version 1.0.0',style: greyTextStyle,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}