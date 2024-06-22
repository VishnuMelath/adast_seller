

import 'dart:developer';

import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/item_detail_page/UI/widgets/resizable_container.dart';
import 'package:adast_seller/features/add_update_item/UI/add_update_item.dart';
import 'package:adast_seller/features/item_detail_page/bloc/item_details_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ItemDetailsBloc itemDetailsBloc = context.read();
   
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
                    itemDetailsBloc.add(ItemDetailsChangedEvent(item: value));
                  },
                );
              },
              backgroundColor: green,
              label: const Text(
                'Update',
                style: whiteTextStyle,
              )),
          body: BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
            builder: (context, state) {
            
            if(state is ItemDetailsChangedState)
            {log('changes');
              itemDetailsBloc.item=state.item;
            }
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: green,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: PageView.builder(
                      itemCount: itemDetailsBloc.item.images.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: CachedNetworkImage(
                            width:  MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                            imageUrl: itemDetailsBloc.item.images[index],
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey[300],
                                height: 200,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        );
                      },
                    ),
                  ),
                   ResizableContainer(
                    minHeight: MediaQuery.of(context).size.height*.3,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
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
