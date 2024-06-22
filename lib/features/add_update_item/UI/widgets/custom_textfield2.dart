import 'package:flutter/material.dart';

class CustomTextfield2 extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final bool number;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const CustomTextfield2(
      {super.key,
      this.number = false,
      this.validator,
      required this.label,
      required this.controller,
      this.maxLines = 1,
      this.onChanged});

  @override
  State<CustomTextfield2> createState() => _CustomTextfield2State();
}

class _CustomTextfield2State extends State<CustomTextfield2> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextFormField(
            keyboardType:
                widget.number ? TextInputType.number : TextInputType.multiline,
            maxLines: widget.maxLines + 2,
            minLines: widget.maxLines,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            onChanged: widget.onChanged,
            decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 12),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                isDense: true,
                border: OutlineInputBorder()),
            validator:widget.validator ?? (value) {
              if (value == '' || value == null) {
                return '${widget.label} cannot be empty';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
