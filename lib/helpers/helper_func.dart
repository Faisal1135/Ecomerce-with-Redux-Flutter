import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HelperFunction {
  static Widget inputForm({
    @required String label,
    @required String hint,
    @required IconData icon,
    @required Function validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          hintText: hint,
          icon: Icon(
            icon,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  static Widget textForm({
    @required String name,
    @required String label,
    @required String hint,
    bool obscure,
    IconData icon,
    Widget suffix,
    @required List<Function> validator,
  }) {
    InputDecoration decoration = InputDecoration(
      border: OutlineInputBorder(),
      icon: Icon(icon),
      hintText: hint,
      labelText: label,
    );

    bool show = obscure ?? false;

    if (suffix != null) {
      decoration = decoration.copyWith(suffixIcon: suffix);
    }
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: name,
        obscureText: show,
        decoration: decoration,
        validator: FormBuilderValidators.compose([...validator]),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
