import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../providers/auth.dart';
import '../../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                children: <Widget>[
                  //Logo
                  Stack(children: <Widget>[
                    Positioned(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            margin:
                                EdgeInsets.only(top: deviceSize.height / 20),
                            alignment: Alignment.bottomCenter,
                            height: deviceSize.height / 10,
                            width: deviceSize.width / 3,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/giaviet.png')))),
                      ),
                    ),
                  ]),
                  //Image
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      height: deviceSize.height / 5,
                      width: deviceSize.width * (2 / 3),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/firstimage.png')))),
                  //Login Form
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: AuthCard(),
                  )
                ],
              )),
        ));
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': '', 'password': ''};
  var _isLoading = false;
  final _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: _authMode == AuthMode.Signup ? 420 : 260,
      constraints:
          BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
      width: deviceSize.width * 0.75,
      padding: EdgeInsets.all(10.0),
      child: 

      //Form Login | Sign Up
      Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Email text field
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                  filled: true,
                  fillColor: Color(0x062961),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.isNotEmpty) {
                    return 'Username is empty';
                  }
                },
                onSaved: (value) {
                  _authData['email'] = value;
                },
              ),
              // Password text field
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.lock), labelText: 'Password'),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty || value.length < 6) {
                    return 'Password is too short';
                  }
                },
                onSaved: (value) {
                  _authData['password'] = value;
                },
              ),

              // Show confirm password field if authMode is SignUp
              if (_authMode == AuthMode.Signup)
                TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                        icon: Icon(Icons.compare),
                        labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Password do not match';
                            }
                          }
                        : null),
              SizedBox(height: 20),

              //Submit Button
              if (_isLoading)
                CircularProgressIndicator()
              else
                Container(
                  height: 50,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: _submit,
                    child: InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF188774),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                    child: Text(
                                  _authMode == AuthMode.Login
                                      ? 'Login'
                                      : 'Signup',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ))
                              ])),
                    ),
                  ),
                ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(Icons.check_box),
                    Text(
                      'Remember me',
                      style: TextStyle(fontSize: 12),
                    )
                  ]),
                  Row(children: <Widget>[
                    Text(
                      'Have an account ',
                      style: TextStyle(fontSize: 12),
                    ),
                    InkWell(
                      child: Text(
                        '${_authMode == AuthMode.Login ? 'Signup' : 'Login'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF188774),
                        ),
                      ),
                      onTap: _switchAuthMode,
                    )
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  
  //Show Error DiaLog if has error !
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An error occured'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    })
              ],
            ));
  }
  //Handle function submit
  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email'], _authData['password']);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

}
