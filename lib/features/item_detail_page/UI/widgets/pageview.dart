
import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../bloc/item_details_bloc.dart';

Widget customPageView(BuildContext context,ItemDetailsBloc itemDetailsBloc,List<Widget> images )
{
  return Container(
                      color: green,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: PageView(
                          onPageChanged: (value) {
                            itemDetailsBloc.add(
                                ItemDetailsPageSwitchEvent(index: value + 1));
                          },
                          children: images),
                    );
}