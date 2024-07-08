import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/custom_widgets/custom_button.dart';
import 'package:adast_seller/features/inventory/UI/widgets/custom_multi_select.dart';
import 'package:adast_seller/features/inventory/UI/widgets/price_range_widget.dart';
import 'package:adast_seller/features/inventory/bloc/inventory_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/themes.dart';

void showFilters(BuildContext context, InventoryBloc inventoryBloc) {
  showModalBottomSheet(
  isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    isDismissible: true,
    context: context,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,left: 10,right: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height*0.8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Filter',style: greyTextStyle,),
              CustomMultiSelectFilter(
                options: inventoryBloc.categories.toList(),
                inventoryBloc: inventoryBloc,
                hint: 'Category',
                selectedOptions: inventoryBloc.selectedCategory,
              ),
              CustomMultiSelectFilter(
                options: inventoryBloc.brands.toList(),
                inventoryBloc: inventoryBloc,
                hint: 'Brand',
                selectedOptions: inventoryBloc.selectedBrands,
              ),
              PriceRangeWidget(inventoryBloc: inventoryBloc),
              CustomMultiSelectFilter(
                  options: fabric,
                  inventoryBloc: inventoryBloc,
                  hint: 'Fabric',
                  selectedOptions: inventoryBloc.selectedFabric),
              CustomMultiSelectFilter(
                  options: fits,
                  inventoryBloc: inventoryBloc,
                  hint: 'Fit',
                  selectedOptions: inventoryBloc.selectedFit),
              CustomButton(onTap: () {
                inventoryBloc.add(InventorySearchEvent());
                Navigator.pop(context);
              }, text: 'apply'),
                  const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    ),
  );
}
