import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/inventory/bloc/inventory_bloc.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CustomMultiSelectFilter extends StatelessWidget {
  final String hint;
  final List<String> options;
  final InventoryBloc inventoryBloc;
  final List<String> selectedOptions;

  const CustomMultiSelectFilter(
      {super.key,
      required this.options,
      required this.inventoryBloc,
      required this.hint,
      required this.selectedOptions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MultiSelectDropDown(
        searchEnabled: true,
        hintStyle: blackTextStyle,
          hint: hint,
          selectedOptions: selectedOptions
              .map(
                (e) => ValueItem(label: e, value: e),
              )
              .toList(),
          clearIcon: const Icon(
            Icons.abc,
            size: 0,
          ),
          onOptionRemoved: (index, option) {
            selectedOptions.remove(option.value);
          },
          onOptionSelected: (selectedOptions1) {
            
                selectedOptions.clear();
                selectedOptions.addAll(selectedOptions1
                .map(
                  (element) => element.value!,
                ));
          },
          options: options
              .map(
                (e) => ValueItem(label: e, value: e),
              )
              .toList()),
    );
  }
}
