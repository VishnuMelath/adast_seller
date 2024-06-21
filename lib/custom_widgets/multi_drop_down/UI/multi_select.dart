import 'dart:developer';

import 'package:adast_seller/custom_widgets/custom_textfield2.dart';
import 'package:adast_seller/custom_widgets/multi_drop_down/bloc/multi_dd_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../ themes/colors_shemes.dart';
import '../../../ themes/constants.dart';
import '../../../ themes/themes.dart';

class CustmMultiselectionDropdownT extends StatelessWidget {
  final Function(List<ValueItem<String>>) onOptionSelected;
  final Function(int, ValueItem<String>) onOptionRemoved;
  final MultiDdBloc multiDdBloc;

  const CustmMultiselectionDropdownT(
      {super.key,
      required this.onOptionSelected,
      required this.multiDdBloc,
      required this.onOptionRemoved});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'available size',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        MultiSelectDropDown(
            borderWidth: .5,
            borderColor: Colors.black,
            fieldBackgroundColor: Colors.transparent,
            borderRadius: 5,
            hint: '',
            onOptionRemoved: onOptionRemoved,
            onOptionSelected: onOptionSelected,
            options: sizes
                .map(
                  (value) => ValueItem(label: value, value: value),
                )
                .toList()),
        BlocBuilder(
          bloc: multiDdBloc,
          builder: (context, state) {
            log(state.runtimeType.toString());
            if (state is MultiDdOptionChangedState) {
              List<Widget> widgets = [];
              multiDdBloc.countMap.forEach(
                (key, value) {
                  widgets.add(Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Size',
                            style: blackTextStyle,
                          ),
                          Container(
                            // margin:const EdgeInsets.only(top: 10),
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: green),
                            child: Center(
                              child: Text(
                                key,
                                style: whiteHeadTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: CustomTextfield2(
                            label: 'Stock quatitiy',
                            controller: TextEditingController(),
                            onChanged: (value) {
                              multiDdBloc.countMap[key]![0] = int.parse(value);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          child: CustomTextfield2(
                              label: 'Reservable',
                              controller: TextEditingController(),
                              onChanged: (value) {
                                multiDdBloc.countMap[key]![1] =
                                    int.parse(value);
                              }))
                    ],
                  ));
                },
              );
              return Column(
                  mainAxisSize: MainAxisSize.min, children: [...widgets]);
            } else {
              if (multiDdBloc.countMap.isEmpty) {
                return const SizedBox();
              } else {
                List<Widget> widgets = [];
                multiDdBloc.countMap.forEach(
                  (key, value) {
                    widgets.add(
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: green),
                            child: Text(
                              key,
                              style: whiteHeadTextStyle,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: CustomTextfield2(
                                label: 'Stock quatitiy',
                                controller: TextEditingController(),
                                onChanged: (value) {
                                  multiDdBloc.countMap[key]![0] =
                                      int.parse(value);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                              child: CustomTextfield2(
                                  label: 'Reservable',
                                  controller: TextEditingController(),
                                  onChanged: (value) {
                                    multiDdBloc.countMap[key]![1] =
                                        int.parse(value);
                                  }))
                        ],
                      ),
                    );
                  },
                );
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [...widgets],
                );
              }
            }
          },
        )
      ],
    );
  }
}

// countMap.isEmpty?
          
          //    const SizedBox():
         
          //   List<Widget> widgets=[];
          //   widget.countMap.forEach((key, value) {
          //     widgets.add(Row(
          //       children: [
          //         Container(
          //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: green),
          //           child: Text(key,style: whiteHeadTextStyle,),
          //         )
          //       ],
          //     ));
          //   },);
          //   return Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //      ...widgets
          //     ]
          //   );