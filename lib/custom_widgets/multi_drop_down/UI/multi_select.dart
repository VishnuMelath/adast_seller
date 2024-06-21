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
  final Function(List<ValueItem<Object?>>) onOptionSelected;
  final Function(int, ValueItem<Object?>) onOptionRemoved;
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
            selectedOptions: multiDdBloc.countMap.keys
                .map(
                  (e) => ValueItem(label: e, value: e),
                )
                .toList(),
            clearIcon: const Icon(
              Icons.arrow_circle_down_sharp,
              size: 0,
            ),
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
                            controller: TextEditingController(
                                text: value[0].toString()),
                            onChanged: (value) {
                              multiDdBloc.countMap[key]![0] = int.parse(value);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          child: CustomTextfield2(
                              label: 'Reservable',
                              controller: TextEditingController(
                                  text: value[1].toString()),
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
                            controller: TextEditingController(
                                text: value[0].toString()),
                            onChanged: (value) {
                              multiDdBloc.countMap[key]![0] = int.parse(value);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          child: CustomTextfield2(
                              label: 'Reservable',
                              controller: TextEditingController(
                                  text: value[1].toString()),
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