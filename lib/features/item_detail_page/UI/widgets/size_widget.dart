import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/features/item_detail_page/bloc/item_details_bloc.dart';
import 'package:flutter/material.dart';

class SizeWidget extends StatelessWidget {
  final ItemDetailsBloc itemDetailsBloc;
  const SizeWidget({super.key, required this.itemDetailsBloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...itemDetailsBloc.item.size.keys.map(
          (e) => GestureDetector(
            onTap: () {
              itemDetailsBloc.add(ItemDetailsSizeChangedEvent(size: e));
            },
            child: Container(
              width: 30,
              height: 30,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                  color: e == itemDetailsBloc.selectedSize ? green : white),
              child: Center(child: Text(e)),
            ),
          ),
        )
      ],
    );
  }
}
