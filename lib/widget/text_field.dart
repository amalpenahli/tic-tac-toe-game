import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFieldContainer extends StatefulWidget {
  String text;
  TextEditingController controller = TextEditingController();
  TextFieldContainer({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       const SizedBox(height: 10,),
        TextFormField(
        
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.text,
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.green,width: 4)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.green,width: 4)),
          ),
        )
      ],
    );
  }
}
