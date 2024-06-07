import 'package:flutter/material.dart';

import '../../../ themes/themes.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Complete Profile',
          style: greenTextStyle,
        ),
      ),
      body: Form(child: ListView(
        children: [ 
          
        ],
      )),
    );
  }
}