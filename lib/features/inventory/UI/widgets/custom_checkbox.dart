import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/inventory/bloc/inventory_bloc.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;
  final InventoryBloc inventoryBloc;
  final int index;
  const CustomCheckbox(
      {super.key,
      required this.label,
      required this.inventoryBloc,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          groupValue: inventoryBloc.sortOption,
          value: index,
          onChanged: (value) {
            inventoryBloc.sortOption=value as int;
            inventoryBloc.add(InventorySearchEvent());
            Navigator.pop(context);
          },
        ),
        Text(
          label,
          style: blackTextStyle,
        )
      ],
    );
  }
}
