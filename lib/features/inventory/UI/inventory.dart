import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/features/add_update_item/UI/add_update_item.dart';
import 'package:adast_seller/features/inventory/bloc/inventory_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    InventoryBloc inventoryBloc = InventoryBloc();
    return BlocProvider<InventoryBloc>(
      create: (context) => inventoryBloc,
      child: BlocConsumer<InventoryBloc, InventoryState>(
        listener: (context, state) {
          if(state is InventoryNavigateToAddItemState)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>const AddUpdateItem(),)) ;
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: green,
              onPressed: () {
                inventoryBloc.add(InventoryAddButtonPressedEvent());
              },
              child: const Icon(
                Icons.add,
                color: white,
              ),
            ),
            body: ListView(
              children: const [],
            ),
          );
        },
      ),
    );
  }
}
