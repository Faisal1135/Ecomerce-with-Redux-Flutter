import 'package:flutter/material.dart';
import 'package:flutter_ecomerce/auth/screens/login_screen.dart';
import 'package:flutter_ecomerce/helpers/helper_func.dart';
import 'package:flutter_ecomerce/products/product_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../helpers/final_and_const.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "register_screen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fbkey = GlobalKey<FormBuilderState>();
  final _sckey = GlobalKey<ScaffoldState>();
  bool obscure = true;
  bool _isLoading = false;

  _showSnack(String msg) {
    final snack = SnackBar(content: Text(msg));
    _sckey.currentState.showSnackBar(snack);
  }

  void _submitForm() async {
    if (_fbkey.currentState.saveAndValidate()) {
      print(_fbkey.currentState.value);
      setState(() {
        _isLoading = !_isLoading;
      });

      await dio
          .post("/auth/local/register", data: _fbkey.currentState.value)
          .then((_) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sckey,
      appBar: AppBar(
        title: Text('Register'),
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
                          'Register Screen',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        HelperFunction.textForm(
                            name: 'username',
                            label: "Username",
                            hint: "Enter Your UserName",
                            icon: Icons.face,
                            validator: [
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.minLength(context, 6)
                            ]),
                        HelperFunction.textForm(
                            label: "Email",
                            hint: "Enter Your email",
                            icon: Icons.email,
                            name: "email",
                            validator: [
                              FormBuilderValidators.email(context),
                              FormBuilderValidators.required(context)
                            ]),
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
                                    context, LoginScreen.routeName),
                                child: Text('Existing User? Login'),
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
