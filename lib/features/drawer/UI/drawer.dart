import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/chat/chat_list/UI/chat_list_page.dart';
import 'package:adast_seller/features/chat/chat_list/bloc/chat_list_bloc.dart';
import 'package:adast_seller/features/drawer/UI/cutom_drawer_option.dart';
import 'package:adast_seller/features/drawer/bloc/drawer_bloc.dart';
import 'package:adast_seller/features/inventory/UI/inventory.dart';
import 'package:adast_seller/features/inventory/bloc/inventory_bloc.dart';
import 'package:adast_seller/features/login_screen/UI/login_screen.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = DrawerBloc();

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
        backgroundColor: drawerColor,
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
                        radius: 60,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                context.watch<LoginBloc>().sellerModel!.image!,
                            fit: BoxFit.cover, // Fills the circle
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: green,
                              child: Container(
                                color: Colors.grey[300],
                                height: 200,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
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
              TextButton(
                  onPressed: () {
                    drawerBloc.add(DrawerLogoutPressedEvent());
                  },
                  child: Text(
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
                return BlocProvider(
                  create: (context) => InventoryBloc(),
                  child: const InventoryPage(),
                );
              case 2:
                return const Center(child: Text('Reservations'));
              case 3:
                return BlocProvider(
                  create: (context) => ChatListBloc(),
                  child: const ChatListPage(),
                );
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
