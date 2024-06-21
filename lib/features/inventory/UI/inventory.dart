import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/custom_widgets/custom_grid.dart';
import 'package:adast_seller/custom_widgets/custom_textfield.dart';
import 'package:adast_seller/features/add_update_item/UI/add_update_item.dart';
import 'package:adast_seller/features/inventory/bloc/inventory_bloc.dart';
import 'package:adast_seller/features/item_detail_page/UI/item_detail.dart';
import 'package:adast_seller/features/item_detail_page/bloc/item_details_bloc.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    InventoryBloc inventoryBloc = BlocProvider.of<InventoryBloc>(context);
    inventoryBloc.add(InventoryInitialEvent(
        email: context.read<LoginBloc>().sellerModel!.email));
    return Column(
      children: [
        Expanded(
          child: Scaffold(
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
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomTextfield(
                    label: 'Search',
                    controller: TextEditingController(),
                    search: true,
                  ),
                ),
                Expanded(
                  child: BlocConsumer<InventoryBloc, InventoryState>(
                    listener: (context, state) {
                      if (state is InventoryNavigateToAddItemState) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddItem(),
                            )).then(
                          (value) {
                            inventoryBloc.add(InventoryInitialEvent(
                                email: context
                                    .read<LoginBloc>()
                                    .sellerModel!
                                    .email));
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is InventoryLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is InventoryEmptyState) {
                        return const Center(
                          child: Text(
                            'No items available',
                            style: blackTextStyle,
                          ),
                        );
                      } else if (state is InventoryLoadedState) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 2,
                                      childAspectRatio: 0.7,
                                      crossAxisCount: 2),
                              itemCount: inventoryBloc.showingItems.length,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  ItemDetailsBloc(
                                                      item: inventoryBloc
                                                          .showingItems[index]),
                                              child: const ItemDetails(),
                                            ),
                                          )).then(
                                        (value) {
                                          if (value == true) {
                                            inventoryBloc.add(
                                              InventoryInitialEvent(
                                                  email: context
                                                      .read<LoginBloc>()
                                                      .sellerModel!
                                                      .email),
                                            );
                                          }
                                        },
                                      );
                                    },
                                    child: CustomGrid(
                                        clothModel:
                                            inventoryBloc.showingItems[index]),
                                  )),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const Material(
          elevation: 10,
          child: Row(
            children: [
              Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('sort', style: blackTextStyle),
                      ))),
              Icon(Icons.restart_alt_rounded),
              Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'filter',
                          style: blackTextStyle,
                        ),
                      )))
            ],
          ),
        )
      ],
    );
  }
}
