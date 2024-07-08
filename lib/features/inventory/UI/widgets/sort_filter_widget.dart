import 'package:flutter/material.dart';

import '../../../../ themes/themes.dart';

class SortFilterWidget extends StatelessWidget {
  final void Function()? onTap;
  final IconData icons;
  final String label;
  const SortFilterWidget(
      {super.key, this.onTap, required this.icons, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icons),
                  Text(label, style: blackTextStyle),
                ],
              ),
            )),
      ),
    );
  }
}
