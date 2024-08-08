import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/inventory/bloc/inventory_bloc.dart';
import 'package:flutter/material.dart';

class PriceRangeWidget extends StatefulWidget {
  final InventoryBloc inventoryBloc;
  const PriceRangeWidget({super.key, required this.inventoryBloc});

  @override
  State<PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {
  @override
  void initState() {
    super.initState();
     widget.inventoryBloc.priceRangeValues=RangeValues(widget.inventoryBloc.minPrice.toDouble(), widget.inventoryBloc.maxPrice.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text('Price range',style: blackTextStyle,),
               Text('${widget.inventoryBloc.priceRangeValues.start.round()} - ${widget.inventoryBloc.priceRangeValues.end.round()} ',style: smallBlackTextStyle,)
             ],
           ),
          RangeSlider(
            divisions: 1000,
            min: widget.inventoryBloc.minPrice.toDouble(),
            max: widget.inventoryBloc.maxPrice.toDouble(),
            labels: RangeLabels(widget.inventoryBloc.priceRangeValues.start.round().toString(),
                widget.inventoryBloc.priceRangeValues.end.round().toString()),
            values: widget.inventoryBloc.priceRangeValues,
            onChanged: (value) {
              widget.inventoryBloc.priceRangeValues = value;
              setState(() {
                
              });
              
            },
          ),
        ],
      ),
    );
  }
}
