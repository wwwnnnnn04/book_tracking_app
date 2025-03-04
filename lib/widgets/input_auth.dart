import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputAuth extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller ;
  final FormFieldValidator<String>? validate;

  InputAuth({Key? key,  required this.label,
    required this.hintText,
    required this.controller,
    required this.validate,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  hintText: hintText,
                  hintStyle:const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(),
                  errorMaxLines: 3,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: validate,
    );
  }
}