import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/methods/common_methods.dart';
import 'package:adast_seller/models/cloth_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomGrid extends StatelessWidget {
  final ClothModel clothModel;
  const CustomGrid({
    super.key,
    required this.clothModel,
  });

  @override
  Widget build(BuildContext context) {
    double width=kIsWeb?MediaQuery.of(context).size.width * 0.163:MediaQuery.of(context).size.width * 0.463;
    return Padding(
      padding: const EdgeInsets.only(top: 1, left: 1),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: greentransparent.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: clothModel.images[0],
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey[300],
                      height: width*1.5,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),SizedBox(
              width: width,
              child: Text(
                overflow: TextOverflow.ellipsis,
                clothModel.name,
                style: mediumBlackTextStyle,
              ),
            ),
            Text(
              '₹ ${clothModel.price}',
              style: smallBlackTextStyle,
            ),
            
            Text(dateString(clothModel.date),style: smallGreyTextStyle,)
          ],
        ),
      ),
    );
  }
}
