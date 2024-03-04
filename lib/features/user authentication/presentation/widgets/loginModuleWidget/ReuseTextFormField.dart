import 'package:flutter/material.dart';

class ReusableTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final IconData prefIcon;
  final IconData? sufIcon;

  const ReusableTextFormField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.keyboardType,
      required this.prefIcon,
      this.sufIcon});

  @override
  State<ReusableTextFormField> createState() => _ReusableTextFormFieldState();
}

class _ReusableTextFormFieldState extends State<ReusableTextFormField> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return SizedBox(
        height: deviceSize.height * 0.08,
        width: deviceSize.width * 0.8,
        child: TextFormField(
            obscureText: widget.sufIcon != null ? isVisible : false,

            // decoration: InputDecoration(
            //     contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            //     errorStyle: const TextStyle(fontSize: 0.05),
            //     border: const OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(4))),
            //     labelText: 'Email address',
            //     labelStyle: TextStyle(fontSize: deviceSize.width * 0.015)),
            style: Theme.of(context).textTheme.labelLarge,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              suffix: widget.sufIcon != null
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: isVisible
                          ? const Padding(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: Icon(
                                Icons.visibility_outlined,
                                size: 17,
                                color: Color.fromARGB(255, 47, 47, 47),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: Icon(
                                Icons.visibility_off_outlined,
                                size: 17,
                                color: Color.fromARGB(255, 47, 47, 47),
                              ),
                            ))
                  : null,
              prefixIcon: Icon(
                widget.prefIcon,
                size: 20,
                color: Colors.grey,
              ),
              labelText: widget.labelText,
              labelStyle: Theme.of(context).textTheme.labelLarge,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              errorStyle: const TextStyle(fontSize: 0.05),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            )));
  }
}
