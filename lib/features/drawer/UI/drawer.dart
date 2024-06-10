import 'dart:developer';

import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/custom_widgets/cutom_drawer_option.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> options=[
       customListTile(() {
              log('Dashboard');
            }, 'Dashboard'),
            customListTile(() {
              log('Inventory');
            }, 'Inventory'),
            customListTile(() {
              log('Inventory');
            }, 'Reservations'),
            customListTile(() {
              log('Inventory');
            }, 'Inbox'),
            customListTile(() {
              log('Inventory');
            }, 'Revenue'),
            customListTile(() {
              log('Inventory');
            }, 'Settings'),
    ];
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: green,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 38.0,
                    ),
                    child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            context.watch<LoginBloc>().sellerModel!.image!)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      context.watch<LoginBloc>().sellerModel!.name,
                      style: whiteHeadTextStyle,
                    ),
                  )
                ],
              ),
            ),
           ...options
          ],
        ),
      ),
    );
  }
}
