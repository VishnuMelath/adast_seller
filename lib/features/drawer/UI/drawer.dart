import 'dart:developer';

import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/custom_widgets/cutom_drawer_option.dart';
import 'package:adast_seller/features/drawer/bloc/drawer_bloc.dart';
import 'package:adast_seller/features/inventory/UI/inventory.dart';
import 'package:adast_seller/features/login_screen/UI/login_screen.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = DrawerBloc();

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder(
          bloc: drawerBloc,
          builder: (context, state) {
            if (state is DrawerOptionState) {
              return Text(
                options[state.index],
                style: greenTextStyle,
              );
            } else {
              return Text(
                options[0],
                style: greenTextStyle,
              );
            }
          },
        ),
      ),
      drawer: Drawer(
        child: BlocListener<DrawerBloc, DrawerState>(
          bloc: drawerBloc,
          listener: (context, state) {
            if (state is DrawerLogoutPressedState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            }
          },
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
              ...List.generate(
                6,
                (index) => customListTile(() {
                  Navigator.pop(context);
                  drawerBloc.add(DrawerOptionTappedEvent(index: index));
                }, options[index]),
              ),
              TextButton(
                  onPressed: () {
                    drawerBloc.add(DrawerLogoutPressedEvent());
                  },
                  child: const Text(
                    'Logout',
                    style: redTextStyle,
                  ))
            ],
          ),
        ),
      ),
      body: BlocBuilder(
        bloc: drawerBloc,
        builder: (context, state) {
          if (state is DrawerOptionState) {
            switch (state.index) {
              case 0:
                return const Center(child: Text('Dashboard'));
              case 1:
                return const InventoryPage();
              case 2:
                return const Center(child: Text('Reservations'));
              case 3:
                return const Center(child: Text('Inbox'));
              case 4:
                return const Center(child: Text('Revenue'));
              case 5:
                return const Center(child: Text('Settings'));
              default:
                return const Center(child: Text('Dashboard'));
            }
          } else {
            return const Center(child: Text('Dashboard'));
          }
        },
      ),
    );
  }
}
