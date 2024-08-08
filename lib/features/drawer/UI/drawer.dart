import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/chat/chat_list/UI/chat_list_page.dart';
import 'package:adast_seller/features/chat/chat_list/bloc/chat_list_bloc.dart';
import 'package:adast_seller/features/dashboard/UI/dashboard.dart';
import 'package:adast_seller/features/drawer/UI/widgets/cutom_drawer_option.dart';
import 'package:adast_seller/features/drawer/bloc/drawer_bloc.dart';
import 'package:adast_seller/features/inventory/UI/inventory.dart';
import 'package:adast_seller/features/inventory/bloc/inventory_bloc.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/features/reservations/UI/reservation.dart';
import 'package:adast_seller/features/revenue/UI/revenue.dart';
import 'package:adast_seller/features/settings/UI/settings.dart';
import 'package:adast_seller/features/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = context.read();
    SettingsBloc settingsBloc = SettingsBloc();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: BlocBuilder(
          bloc: drawerBloc,
          builder: (context, state) {
            if (state is DrawerOptionState) {
              return Text(
                drawerOptions[state.index],
                style: greenTextStyle,
              );
            } else {
              return Text(
                drawerOptions[0],
                style: greenTextStyle,
              );
            }
          },
        ),
      ),
      drawer: Drawer(
        width: 270,
        backgroundColor: drawerColor,
        child: BlocBuilder<SettingsBloc, SettingsState>(
          bloc: settingsBloc,
          builder: (context, state) {
          
            return  Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          context.watch<LoginBloc>().sellerModel!.image!,
                        ))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: green,
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              backgroundColor,
                            ],
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      height: 250,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            context.watch<LoginBloc>().sellerModel!.name,
                            style: whiteHeadTextStyle,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ...List.generate(
                6,
                (index) {
                  return BlocBuilder<DrawerBloc, DrawerState>(
                    bloc: drawerBloc,
                    builder: (context, state) {
                      int selectedIndex = 0;
                      if (state is DrawerOptionState) {
                        selectedIndex = state.index;
                      }
                      return customListTile(
                        onTap: () {
                          Navigator.pop(context);
                          drawerBloc.add(DrawerOptionTappedEvent(index: index));
                        },
                        tapped: index == selectedIndex,
                        title: drawerOptions[index],
                      );
                    },
                  );
                },
              ),
            ],
          );
          },
        
        ),
      ),
      body: BlocBuilder(
        bloc: drawerBloc,
        builder: (context, state) {
          if (state is DrawerOptionState) {
            switch (state.index) {
              case 0:
                return const Dashboard();
              case 1:
                return BlocProvider(
                  create: (context) => InventoryBloc(),
                  child: const InventoryPage(),
                );
              case 2:
                return const ReservationsList();
              case 3:
                return BlocProvider(
                  create: (context) => ChatListBloc(),
                  child: const ChatListPage(),
                );
              case 4:
                return const RevenuePage();
              case 5:
                return BlocProvider(
                  create: (context) => settingsBloc,
                  child: const SettingsPage(),
                );
              default:
                return const Dashboard();
            }
          } else {
            return const Dashboard();
          }
        },
      ),
    );
  }
}
