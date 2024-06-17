import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../ themes/constants.dart';

class CustmMultiselectionDropdown extends StatelessWidget {
  final Function(List<ValueItem<String>>) onOptionSelected;
  const CustmMultiselectionDropdown(
      {super.key, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
         const Text('available size',style: TextStyle(fontWeight: FontWeight.w600),),
        MultiSelectDropDown(
            hint: '',
            onOptionSelected: onOptionSelected,
            options: sizes
                .map(
                  (value) => ValueItem(label: value, value: value),
                )
                .toList()),
      ],
    );
  }
}
