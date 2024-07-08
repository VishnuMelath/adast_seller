import 'dart:developer';

import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/item_detail_page/UI/widgets/resizable_container.dart';
import 'package:adast_seller/features/add_update_item/UI/add_update_item.dart';
import 'package:adast_seller/features/item_detail_page/bloc/item_details_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

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
                    reload = true;
                    itemDetailsBloc.add(ItemDetailsChangedEvent(item: value));
                  },
                );
              },
              backgroundColor: green,
              label:  Text(
                'Update',
                style: whiteTextStyle,
              )),
          body: BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
            builder: (context, state) {
              if (state is ItemDetailsChangedState) {
                log('changes');
                itemDetailsBloc.item = state.item;
              }

              List<Widget> images=itemDetailsBloc.item.images.map(
                          (e) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: InteractiveViewer(
                                child: CachedNetworkImage(
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                  imageUrl: e,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: green,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              1.5,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                        ).toList();
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: green,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: PageView(
                      children: images
                    ),
                  ),
                  ResizableContainer(
                    minHeight: MediaQuery.of(context).size.height * .3,
                  ),
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
