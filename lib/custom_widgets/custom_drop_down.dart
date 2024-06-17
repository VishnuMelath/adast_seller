import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final String label;
  final  Function(String?)? onChanged;
  const CustomDropDown(
      {super.key,
      required this.items,
      required this.selectedValue,
      required this.onChanged,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,style:const TextStyle(fontWeight: FontWeight.w600),),
          DropdownMenu<String>(
            menuHeight: MediaQuery.of(context).size.height*0.88,
            width: MediaQuery.of(context).size.width*0.88,
              hintText: 'select',
              dropdownMenuEntries: items
                  .map((values) => DropdownMenuEntry<String>(
                    label: values,
                    value: values))
                  .toList(),
              onSelected: onChanged),
        ],
      ),
    );
  }
}
