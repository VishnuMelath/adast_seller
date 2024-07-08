import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/inventory/UI/widgets/custom_checkbox.dart';
import 'package:adast_seller/features/inventory/bloc/inventory_bloc.dart';
import 'package:flutter/material.dart';

void showSortBottomSheet(BuildContext context, InventoryBloc inventoryBloc) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    isDismissible: true,
    context: context,
    builder: (context) => Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width*.0),
          child: Text('Sort by',style: greyTextStyle,),
        ),
        CustomCheckbox(label: 'price : low to high', inventoryBloc: inventoryBloc, index: 1),
        CustomCheckbox(label: 'price : high to low', inventoryBloc: inventoryBloc, index: 2),
        CustomCheckbox(label: 'item : new to old', inventoryBloc: inventoryBloc, index: 3),
        CustomCheckbox(label: 'item : old to new', inventoryBloc: inventoryBloc, index: 4),
        CustomCheckbox(label: 'item left : low to high', inventoryBloc: inventoryBloc, index: 5),
        CustomCheckbox(label: 'item left: high to low', inventoryBloc: inventoryBloc, index: 6),
        const SizedBox(height: 30,)
      ],
    ),
  );
}
