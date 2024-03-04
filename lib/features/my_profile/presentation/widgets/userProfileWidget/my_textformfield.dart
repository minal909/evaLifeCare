import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelTextl;
  final String hintText;
  final TextInputType keyboardType;
  final bool readonly;
  final LengthLimitingTextInputFormatter inputLenght;

  const MyTextFormField(
      {super.key,
      required this.controller,
      required this.labelTextl,
      this.keyboardType = TextInputType.text,
      required this.hintText,
      required this.readonly,
      required this.inputLenght});

  @override
  Widget build(BuildContext context) {
    var screenOrientation = MediaQuery.orientationOf(context);

    return SizedBox(
      height: screenOrientation.toString() == 'Orientation.landscape'
          ? MediaQuery.of(context).size.height * 0.08
          : MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.9,
      // MediaQuery.of(context).size.height > 650 &&
      //         screenOrientation.toString() == 'Orientation.portait'
      //      MediaQuery.of(context).size.width * 0.9
      //     : MediaQuery.of(context).size.width * 0.775,
      child: TextFormField(
        readOnly: readonly,
        // autovalidateMode: AutovalidateMode.onUserInteraction,

        style: Theme.of(context).textTheme.bodySmall,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelTextl,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          errorStyle: const TextStyle(fontSize: 0.05),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        inputFormatters: [inputLenght],
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter value';
          }
          return null;
        },
      ),
    );
  }
}
