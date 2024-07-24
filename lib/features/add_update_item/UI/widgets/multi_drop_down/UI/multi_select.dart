

import 'package:adast_seller/custom_widgets/custom_snackbar.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/custom_textfield2.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/multi_drop_down/bloc/multi_dd_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../../../ themes/colors_shemes.dart';
import '../../../../../../ themes/constants.dart';
import '../../../../../../ themes/themes.dart';

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
            // if (state is MultiDdOptionChangedState) {
            List<Widget> widgets = [];
            multiDdBloc.countMap.forEach(
              (key, value) {
                int value1 = multiDdBloc.reservable[key] ?? 0;
                TextEditingController controller0 =
                    TextEditingController(text: value.toString());
                TextEditingController controller1 =
                    TextEditingController(text: value1.toString());
                widgets.add(Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
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
                          validator: (value) {
                            try {
                              int.parse(value!);
                              return null;
                            } catch (e) {
                              return;
                            }
                          },
                          label: 'Stock quatitiy',
                          controller: controller0,
                          onChanged: (value2) {

                            try {
                              multiDdBloc.countMap[key] = int.parse(value2);
                            } catch (e) {
                              multiDdBloc.countMap[key] = 0;
                            }
                            if (controller1.text.isNotEmpty &&
                                controller0.text.isNotEmpty) {
                              if (int.parse(controller1.text) >
                                  int.parse(controller0.text)) {
                                customSnackBar(context,
                                    'reservable cannot be greater than quantity');
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: CustomTextfield2(
                            validator: (value3) {
                              try {
                                int.parse(value3!);
                                return null;
                              } catch (e) {
                                return;
                              }
                            },
                            label: 'Reservable',
                            controller: controller1,
                            onChanged: (value3) {
                              try {
                                multiDdBloc.reservable[key] = int.parse(value3);
                              } catch (_) {
                                multiDdBloc.reservable[key] = 0;
                              }
                              if (controller1.text.isNotEmpty &&
                                  controller0.text.isNotEmpty) {
                                if (int.parse(controller1.text) >
                                    int.parse(controller0.text)) {
                                  customSnackBar(context,
                                      'reservable cannot be greater than quantity');
                                }
                              }
                            }))
                  ],
                ));
              },
            );
            return Column(
                mainAxisSize: MainAxisSize.min, children: [...widgets]);
            // } else {
            //   List<Widget> widgets = [];
            //   multiDdBloc.countMap.forEach(
            //     (key, value) {
            //       var value1 = multiDdBloc.reservable;
            //       widgets.add(Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               Text(
            //                 'Size',
            //                 style: blackTextStyle,
            //               ),
            //               Container(
            //                 // margin:const EdgeInsets.only(top: 10),
            //                 width: 52,
            //                 height: 52,
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(5),
            //                     color: green),
            //                 child: Center(
            //                   child: Text(
            //                     key,
            //                     style: whiteHeadTextStyle,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           Expanded(
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //               child: CustomTextfield2(
            //                 validator: (p0) {
            //                   return;
            //                 },
            //                 label: 'Stock quatitiy',
            //                 controller:
            //                     TextEditingController(text: value.toString()),
            //                 onChanged: (value) {
            //                   try {
            //                     multiDdBloc.countMap[key] = int.parse(value);
            //                   } catch (_) {
            //                     multiDdBloc.countMap[key] = 0;
            //                   }
            //                 },
            //               ),
            //             ),
            //           ),
            //           Expanded(
            //               child: CustomTextfield2(
            //                   validator: (p0) {
            //                     return;
            //                   },
            //                   label: 'Reservable',
            //                   controller: TextEditingController(
            //                       text: value1.toString()),
            //                   onChanged: (value) {
            //                     try {
            //                       multiDdBloc.reservable[key] =
            //                           int.parse(value);
            //                     } catch (_) {
            //                       multiDdBloc.reservable[key] = 0;
            //                     }
            //                   }))
            //         ],
            //       ));
            //     },
            //   );
            //   return Column(
            //       mainAxisSize: MainAxisSize.min, children: [...widgets]);
            // }
          },
        )
      ],
    );
  }
}
