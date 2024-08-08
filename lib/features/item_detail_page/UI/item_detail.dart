import 'dart:developer';

import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/item_detail_page/UI/widgets/resizable_container.dart';
import 'package:adast_seller/features/add_update_item/UI/add_update_item.dart';
import 'package:adast_seller/features/item_detail_page/bloc/item_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/page_indicator.dart';
import 'widgets/pageview.dart';
import 'widgets/string_to_imagewidget.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ItemDetailsBloc itemDetailsBloc = context.read();
    bool reload = false;
    return Container(
      color: greentransparent,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItem(
                        clothModel: itemDetailsBloc.item,
                      ),
                    )).then(
                  (value) {
                    if (value != null) {
                      reload = true;
                      itemDetailsBloc.add(ItemDetailsChangedEvent(item: value));
                    }
                  },
                );
              },
              backgroundColor: green,
              label: Text(
                'Update',
                style: whiteTextStyle,
              )),
          body: BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
            builder: (context, state) {
              if (state is ItemDetailsChangedState) {
                log('changes');
                itemDetailsBloc.item = state.item;
              }
              List<Widget> images =
                  stringToImageListWidget(itemDetailsBloc.item.images, context);

              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  customPageView(context, itemDetailsBloc, images),
                  ResizableContainer(
                    minHeight: MediaQuery.of(context).size.height * .3,
                  ),
                  pageIndicator(context, images.length, itemDetailsBloc),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context, reload);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: white,
                        )),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
