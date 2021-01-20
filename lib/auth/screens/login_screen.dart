import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/screens/register_screen.dart';
import '../../helpers/helper_func.dart';
import '../../products/product_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../helpers/final_and_const.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fbkey = GlobalKey<FormBuilderState>();
  bool obscure = true;
  final _sckey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  _showSnack(String msg) {
    final snack = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.black,
    );
    _sckey.currentState.showSnackBar(snack);
  }

  void _submitForm() async {
    if (_fbkey.currentState.saveAndValidate()) {
      print(_fbkey.currentState.value);
      setState(() {
        _isLoading = !_isLoading;
      });

      await dio
          .post("/auth/local", data: _fbkey.currentState.value)
          .then((res) {
        final data = Map<String, dynamic>.from(res.data);
        _storeUser(data);

        setState(() {
          _isLoading = !_isLoading;
        });
        _showSnack("User Created SuccessFully");
        Navigator.pushNamed(context, ProductScreen.routeName);
      }).catchError((e) {
        setState(() {
          _isLoading = !_isLoading;
        });
        _showSnack("Something went Wrong!!" + e.toString());
      });
    }
  }

  _storeUser(Map responseData) async {
    final pref = await SharedPreferences.getInstance();
    final user = responseData['user'] as Map<String, dynamic>;
    user.putIfAbsent('jwt', () => responseData['jwt']);
    pref.setString("user", json.encode(user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sckey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: FormBuilder(
                    key: _fbkey,
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        HelperFunction.textForm(
                          name: 'identifier',
                          label: "Email",
                          hint: "Enter Your Email",
                          icon: Icons.mail,
                          validator: [
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.email(context),
                          ],
                        ),
                        HelperFunction.textForm(
                          label: "Password",
                          hint: "Enter Your Password min(8)",
                          icon: Icons.lock,
                          obscure: obscure,
                          name: "password",
                          suffix: IconButton(
                              icon: obscure
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              }),
                          validator: [
                            FormBuilderValidators.minLength(context, 8),
                            FormBuilderValidators.required(context)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Column(
                            children: [
                              RaisedButton(
                                elevation: 8,
                                onPressed: _submitForm,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  'Submit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              FlatButton(
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, RegisterScreen.routeName),
                                child: Text('Create account? Signup'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
