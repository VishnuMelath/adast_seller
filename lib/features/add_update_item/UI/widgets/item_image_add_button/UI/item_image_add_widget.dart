import 'package:adast_seller/features/add_update_item/UI/widgets/item_image_add_button/UI/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/itemimageadd_bloc.dart';

class ItemImageAddWidget extends StatelessWidget {
  const ItemImageAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Images',
                style: TextStyle(fontWeight: FontWeight.w600),
              )),
          SizedBox(
            height: 150,
            child: BlocBuilder<ItemimageaddBloc, ItemimageaddState>(
              builder: (context, state) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<ItemimageaddBloc>().add(
                                ItemImagesAddPressedEvent(),
                              );
                        },
                        child: Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Icon(Icons.add),
                            )),
                      ),
                    ),
                    ...context.read<ItemimageaddBloc>().images.map(
                          (e) => Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 100,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                    
                                      image: NetworkImage(e,),
                                    ),
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<ItemimageaddBloc>().add(
                                        ItemImageRemoveEvent(path: e),
                                      );
                                },
                                icon: const Icon(
                                  Icons.dangerous,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                    if (state is ItemImageUploadingState)
                      ...List.generate(
                        state.count,
                        (index) => customShimmer
                      )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
