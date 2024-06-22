import 'dart:developer';

import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/item_detail_page/UI/widgets/show_dialog_delete.dart';
import 'package:adast_seller/features/item_detail_page/bloc/item_details_bloc.dart';
import 'package:adast_seller/methods/common_methods.dart';
import 'package:adast_seller/services/item_database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResizableContainer extends StatefulWidget {
  final double minHeight;
  final double maxHeight;

  const ResizableContainer({
    super.key,
    this.minHeight = 100.0,
    this.maxHeight = 500.0,
  });

  @override
  State<ResizableContainer> createState() => _ResizableContainerState();
}

class _ResizableContainerState extends State<ResizableContainer> {
  double currentHeight = 500.0; // Initial height

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      currentHeight -= details.delta.dy;
      currentHeight = currentHeight.clamp(widget.minHeight, widget.maxHeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    ItemDetailsBloc itemDetailsBloc = BlocProvider.of(context);
    return BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
      builder: (context, state) {
        log(itemDetailsBloc.item.toMap().toString());
        return Container(
          width: double.infinity,
          height: currentHeight,
          decoration: const BoxDecoration(
              color:white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30))),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onVerticalDragUpdate: onDragUpdate,
                      child: Material(
                        // elevation: 10,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: MediaQuery.of(context).size.width * 0.3),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            width: 80,
                            height: 10,
                            decoration: BoxDecoration(
                                color: green,
                                borderRadius: BorderRadius.circular(10)),
                                                  
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: greenBoxDecoration,
                        child: Text(
                          '${itemDetailsBloc.item.reservedCount[itemDetailsBloc.selectedSize] ?? 0} reserved',
                          style: whiteTextStyle,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: greenBoxDecoration,
                        child: Text(
                          '${itemDetailsBloc.item.size[itemDetailsBloc.selectedSize][0] - (itemDetailsBloc.item.soldCount[itemDetailsBloc.selectedSize] ?? 0)} left',
                          style: whiteTextStyle,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        capitalize(itemDetailsBloc.item.name),
                        style: largeBlackTextStyle,
                      )),
                      IconButton(
                          onPressed: () async {
                            showDialogueDelete(
                              context,
                              onPressed: () async {
                                await ItemDatabaseServices()
                                    .deleteItem(itemDetailsBloc.item.id!)
                                    .then(
                                  (value) {
                                    Navigator.pop(context);
                                    Navigator.pop(context, true);
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                  Text(itemDetailsBloc.item.description,style: greyTextStyle,),
                 const Text('size',style: mediumBlackTextStyle,)
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
