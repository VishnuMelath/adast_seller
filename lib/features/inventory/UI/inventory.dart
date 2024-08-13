
import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/inventory/UI/widgets/custom_grid.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/custom_textfield.dart';
import 'package:adast_seller/features/add_update_item/UI/add_update_item.dart';
import 'package:adast_seller/features/inventory/UI/widgets/filter_widget.dart';
import 'package:adast_seller/features/inventory/UI/widgets/sort_filter_widget.dart';
import 'package:adast_seller/features/inventory/UI/widgets/sort_widget.dart';
import 'package:adast_seller/features/inventory/bloc/inventory_bloc.dart';
import 'package:adast_seller/features/item_detail_page/UI/item_detail.dart';
import 'package:adast_seller/features/item_detail_page/bloc/item_details_bloc.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/methods/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    InventoryBloc inventoryBloc = BlocProvider.of<InventoryBloc>(context);
    Debouncer debouncer = Debouncer(500);
    inventoryBloc.add(InventoryInitialEvent(
        email: context.read<LoginBloc>().sellerModel!.email));
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            backgroundColor: backgroundColor,
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
                    onChanged: (value) {
                      inventoryBloc.searchQuery = value;
                      debouncer.call(
                        () {
                          inventoryBloc.add(InventorySearchEvent());
                        },
                      );
                    },
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
                        return Center(
                          child: Text(
                            'No items found',
                            style: blackTextStyle,
                          ),
                        );
                      }else if(state is InventoryErrorState)
                      {
                        return Center(child: Text(state.error,style: blackTextStyle,));
                      } else if (state is InventoryLoadedState) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                children: [
                                  ...inventoryBloc.showingItems.map(
                                    (e) {
                                      return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider(
                                                    create: (context) =>
                                                        ItemDetailsBloc(
                                                            item: e),
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
                                            clothModel: e,
                                          ));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
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
        Material(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                SortFilterWidget(
                    onTap: () {
                      showFilters(context, inventoryBloc);
                    },
                    icons: Icons.filter_alt_sharp,
                    label: 'filter'),
                GestureDetector(
                  onTap: () {
                    inventoryBloc.add(InventoryClearFilterEvent());
                  },
                  child: const Icon(Icons.restart_alt_rounded)),
                SortFilterWidget(
                    onTap: () {
                      showSortBottomSheet(context, inventoryBloc);
                    }, icons: Icons.sort, label: 'sort'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
