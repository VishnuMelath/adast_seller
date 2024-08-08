import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/methods/common_methods.dart';
import 'package:adast_seller/models/cloth_model.dart';
import 'package:flutter/material.dart';

import '../../../../custom_widgets/custom_cached_network_image.dart';

class CustomRevenueTile extends StatelessWidget {
  final ClothModel item;
  const CustomRevenueTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> notifier = ValueNotifier(false);
    return ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, _) {
          return AnimatedSize(
            curve: Curves.linearToEaseOut,
            duration: const Duration(milliseconds: 1000),
            child: AnimatedContainer(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [backgroundColor, white])),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCachedNetworkImage(
                        image: item.images.first,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              capitalize(item.name),
                              style: mediumBlackTextStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Total Revenue : ₹${item.revenue ~/ 100}',
                              style: blackPlainTextStyle,
                            ),
                            Wrap(
                              children: [
                                customCard(
                                    label: 'Items left',
                                    color: green,
                                    count: (totol(item.size) -
                                        totol(item.soldCount)),),
                                customCard(
                                    label: "Sold",
                                    color: red,
                                    count: totol(item.soldCount),),
                                customCard(
                                    label: "Reserved",
                                    color: red,
                                    count: totol(item.reservedCount),)
                              ],
                            )
                          ],
                        ),
                      ),

                  
                    ],
                  ),
                  
                ],
              ),
            ),
          );
        });
  }
}

int totol(Map<String, dynamic> map) {
  return map.values.fold(
    0,
    (previousValue, element) => previousValue + int.parse(element.toString()),
  );
}

Widget customCard(
    {required String label, required Color color, required int count}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
    margin: const EdgeInsets.only(right: 10, top: 10),
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        Text(
          label,
          style: mediumWhiteTextStyle,
        ),
        Text(count.toString(),
          style: mediumWhiteTextStyle,)
      ],
    ),
  );
}
