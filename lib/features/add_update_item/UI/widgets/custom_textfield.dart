import 'package:flutter/material.dart';

import '../../../../ themes/constants.dart';

class CustomTextfield extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool login;
  final bool password;
  final TextEditingController? passController;
  final int maxLines;
  final bool number;
  final bool search;
  const CustomTextfield({
    super.key,
    this.search=false,
    this.number=false,
    this.login = false,
    this.password = false,
    required this.label,
    required this.controller,
    this.passController,
    this.maxLines=1
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  double elevation = 1;
  bool visible = false;
  late bool show;
  @override
  void initState() {
    show = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top:widget.search? MediaQuery.of(context).size.height * 0.01: MediaQuery.of(context).size.height * 0.03,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: elevation,
        child: TextFormField(
          keyboardType: widget.number?TextInputType.number:TextInputType.text,
          maxLines: widget.maxLines,
          minLines: 1,
          autovalidateMode:widget.search||widget.login||widget.passController!=null
              ? AutovalidateMode.disabled
              : AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          obscureText: show,
          decoration: InputDecoration(
              suffixIcon: Visibility(
                  visible: widget.password&&widget.passController==null,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    icon: eye[show]!,
                  )),
              prefixIcon: Icon(icons[widget.label]),
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              labelText: widget.label,
              isDense: true,
              border: InputBorder.none),
          validator: (value) {
            if (value == '' || value == null) {
              return '${widget.label} cannot be empty';
            }
            else if(widget.passController!=null&&widget.passController!.text!=widget.controller.text)
            {
              return 'passwords doesn\'t matches ';
            }
            return null;
          },
          onTapOutside: (event) {
            elevation = 1;
            FocusManager.instance.primaryFocus?.unfocus();
            setState(() {});
          },
          onTap: () {
            setState(() {
              elevation = 10;
            });
          },
        ),
      ),
    );
  }
}
