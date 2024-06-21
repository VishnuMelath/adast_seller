import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/features/item_detail_page/bloc/item_details_bloc.dart';
import 'package:adast_seller/methods/common_methods.dart';
import 'package:adast_seller/models/cloth_model.dart';
import 'package:adast_seller/services/item_database_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ResizableContainer extends StatefulWidget {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  const ResizableContainer({
    super.key,
    required this.child,
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
    ClothModel clothModel = itemDetailsBloc.item;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: currentHeight,
        decoration: const BoxDecoration(color: white,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onVerticalDragUpdate: onDragUpdate,
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical:  8.0,horizontal: MediaQuery.of(context).size.width*0.3),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 80,
                    height: 10,
                    decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(10)),
                    child: const Divider(),
                  ),
                ),
              ),
              Row( 
                children: [ 
                  Expanded(child: Text(capitalize(clothModel.name),style: largeBlackTextStyle,))
                  ,IconButton(onPressed: () async{
                    await ItemDatabaseServices().deleteItem(clothModel.id!).then((value) {
                      Navigator.pop(context,true);
                    },);

                    
                  }, icon:const Icon(Icons.delete))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
