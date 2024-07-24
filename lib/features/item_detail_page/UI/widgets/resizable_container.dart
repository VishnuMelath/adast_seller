import 'dart:developer';

import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/custom_widgets/custom_button.dart';
import 'package:adast_seller/features/inventory/methods/methods.dart';
import 'package:adast_seller/features/item_detail_page/UI/widgets/drawer_holder.dart';
import 'package:adast_seller/features/item_detail_page/UI/widgets/show_dialog_delete.dart';
import 'package:adast_seller/features/item_detail_page/UI/widgets/size_widget.dart';
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
    this.maxHeight = 700.0,
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
        late int reservedCount;
        late int itemsLeft;
        log('message');
        if (itemDetailsBloc.selectedSize == null) {
          reservedCount = itemDetailsBloc.item.reservedCount.values.fold<int>(
            0,
            (s, e) {
              return s + (e ?? 0) as int;
            },
          );
          itemsLeft = totalItemsLeft(itemDetailsBloc.item);
        } else {
          reservedCount = itemDetailsBloc
                  .item.reservedCount[itemDetailsBloc.selectedSize] ??
              0;
          itemsLeft = itemsLeftForSelectedSize(itemDetailsBloc.item, itemDetailsBloc.selectedSize!);
        }
        log(itemDetailsBloc.item.toMap().toString());
        return Container(
          padding: const EdgeInsets.only(top:10),
          width: double.infinity,
          height: currentHeight,
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onVerticalDragUpdate: onDragUpdate,
                            child: drawerHolder(context),
                          ),
                        ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              decoration: greenBoxDecoration,
                              child: Text(
                                '$reservedCount reserved',
                                style: whiteTextStyle,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              decoration: greenBoxDecoration,
                              child: Text(
                                '$itemsLeft left',
                                style: whiteTextStyle,
                              ),
                            )
                          ],
                        ),
                        Text(
                          capitalize(itemDetailsBloc.item.brand),
                          style: largeBlackTextStyle,
                        ),
                        Text(
                          itemDetailsBloc.item.name,
                          style: blackTextStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text(
                            itemDetailsBloc.item.description,
                            style: greyTextStyle,
                          ),
                        ),
                         Text(
                          'size',
                          style: mediumBlackTextStyle,
                        ),
                        SizeWidget(itemDetailsBloc: itemDetailsBloc),
                        const Divider(),
                         Text(
                          'Product details',
                          style: mediumBlackTextStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width*.4,
                                    child:  Text(
                                      'Material',
                                      style: greyTextStyle,
                                    ),
                                  ),
                
                                  Text(itemDetailsBloc.item.material),
                
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width*.4,
                                    child:  Text(
                                      'Fit',
                                      style: greyTextStyle,
                                    ),
                                  ),
                
                                  Text(itemDetailsBloc.item.fit),
                
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width*.4,
                                    child:  Text(
                                      'Category',
                                      style: greyTextStyle,
                                    ),
                                  ),
                
                                  Text(itemDetailsBloc.item.category),
                
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width*.4,
                                    child:  Text(
                                      'Price',
                                      style: greyTextStyle,
                                    ),
                                  ),
                
                                  Text('${itemDetailsBloc.item.price} ₹'),
                
                                ],
                              ),
                              
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            Align(alignment: Alignment.centerLeft,
              child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width*.6,
                                  child: CustomButton(onTap: () {
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
                                  }, text: 'Delete'),
                                ),
            )],
          ),
        );
      },
    );
  }
}
