import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Validate = String? Function(String?)?;

class EditText extends StatelessWidget {
  final String lapel;
  final bool obscureText;
  final IconButton? iconButton;
  final TextInputType keyboardType;
  final GlobalKey<FormState> formKay;
  final Validate validate;
  final TextEditingController controller;
  final String? defaultValue;

  EditText({
    Key? key,
    required this.lapel,
    required this.obscureText,
    this.iconButton,
    required this.keyboardType,
    required this.formKay,
    this.validate,
    required this.controller,
    this.defaultValue,
  }) : super(key: key) {
    // Set default value to the controller
    if (defaultValue != null) {
      controller.text = defaultValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return TextFormField(
      controller: controller,
      cursorErrorColor: Colors.red,
      validator: validate,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: width * 0.03,
          color: Theme.of(context).colorScheme.onSurface
      ),
      cursorColor: const Color.fromRGBO(53, 152, 219, 1.0),
      decoration: InputDecoration(
        errorStyle:TextStyle(color: Colors.red) ,
        focusedErrorBorder:UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),

        ) ,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromRGBO(53, 152, 219, 1.0),
            width: width * 0.005,
          )
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: width * 0.005,
          )
        ),
        label: Text(
          lapel,
          style: TextStyle(
            fontSize: width * 0.04,
            fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface
          ),
        ),
        suffixIcon: iconButton,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromRGBO(53, 152, 219, 1.0),
            width: width * 0.005,
          ),
        ),
      ),
    );
  }
}
