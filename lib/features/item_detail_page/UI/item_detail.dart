import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/custom_widgets/resizable_container.dart';
import 'package:adast_seller/features/item_detail_page/bloc/item_details_bloc.dart';
import 'package:adast_seller/models/cloth_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ItemDetailsBloc itemDetailsBloc = context.read();
    ClothModel item = itemDetailsBloc.item;
    return Container(
      color: greentransparent,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(onPressed: () {
            
          }, backgroundColor: green,label:const Text('Update',style: whiteTextStyle,)),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                color: green,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PageView.builder(
                  itemCount: item.images.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: item.images[index],
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
              const ResizableContainer(child: Text('hello')),
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
          ),
        ),
      ),
    );
  }
}
