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
      body: 
          SingleChildScrollView(
            child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           colors: [
          //             Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
          //             Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
          //           ],
          //           begin: Alignment.topLeft,
          //           end: Alignment.bottomRight,
          //           stops: [0, 1])),
          // ),
          Positioned(child: Align(
            alignment: Alignment.topCenter,
                      child: Container(
                          margin: EdgeInsets.only(top: deviceSize.height / 20),
                          alignment: Alignment.bottomCenter,
                          height: deviceSize.height / 10,
                          width: deviceSize.width/3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/giaviet.png')))),
          ),),]),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        height: deviceSize.height / 5,
                        width: deviceSize.width * (2 / 3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/firstimage.png')))),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: AuthCard(),
                    )
                    // Flexible(
                    //     child: Container(
                    //         child: Container(
                    //   margin: EdgeInsets.only(bottom: 20),
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: 8, horizontal: 94),
                    //   child: Text(
                    //     'Login',
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    // ))),
                    // Flexible(
                    //   flex: deviceSize.width > 600 ? 2 : 1,
                    //   child: AuthCard(),
                    // )
                  ],
                )),
          )
        
      );
    
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: _authMode == AuthMode.Signup ? 420 : 260,
      constraints:
          BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
      width: deviceSize.width * 0.75,
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                  filled: true,
                  fillColor: Color(0x062961),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Invalid email';
                  }
                },
                onSaved: (value) {
                  _authData['email'] = value;
                },
              ),
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
              // RaisedButton(

              //   child:
              //       Container(
              //         width: double.infinity,
              //         height: 30,
              //         child: Text(_authMode == AuthMode.Login ? 'Login' : 'Signup',
              //         style: TextStyle(
              //           fontSize: 20,
              //           color: Colors.white
              //           ),),
              //       ),
              //   onPressed: _submit,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10)),

              //   color: Theme.of(context).primaryColor,
              // ),
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
                    // FlatButton(
                    //   child: Text(
                    //       '${_authMode == AuthMode.Login ? 'Signup' : 'Login'}'),
                    //   onPressed: _switchAuthMode,
                    // )
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
// class _AuthCardState extends State<AuthCard> {
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   AuthMode _authMode = AuthMode.Login;
//   Map<String, String> _authData = {'email': '', 'password': ''};
//   var _isLoading = false;
//   final _passwordController = TextEditingController();

//   void _showErrorDialog(String message) {
//     showDialog(context: context,
//     builder: (ctx) => AlertDialog(
//       title: Text('An error occured'),
//       content:Text(message),
//       actions: <Widget>[
//         FlatButton(
//           child: Text('Okay'),
//           onPressed: () {
//             Navigator.of(ctx).pop();
//           }
//         )
//       ],
//     ));
//   }
//   void _submit() async {
//     if (!_formKey.currentState.validate()) {
//       return;
//     }
//     _formKey.currentState.save();
//     try {
//       if (_authMode == AuthMode.Login) {
//       await Provider.of<Auth>(context, listen: false)
//           .login(_authData['email'], _authData['password']);
//     } else {
//       await Provider.of<Auth>(context, listen: false)
//           .signup(_authData['email'], _authData['password']);
//     }
//     } on HttpException catch (error) {
//       var errorMessage = 'Authentication failed';
//       if (error.toString().contains('EMAIL_EXISTS')) {
//         errorMessage = 'This email address is already in use.';
//       } else if (error.toString().contains('INVALID_EMAIL')) {
//         errorMessage = 'This is not a valid email address';
//       } else if (error.toString().contains('WEAK_PASSWORD')) {
//         errorMessage = 'This password is too weak.';
//       } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
//         errorMessage = 'Could not find a user with that email.';
//       } else if (error.toString().contains('INVALID_PASSWORD')) {
//         errorMessage = 'Invalid password.';
//       }
//       _showErrorDialog(errorMessage);
//     } catch (error) {
//       const errorMessage =
//           'Could not authenticate you. Please try again later.';
//       _showErrorDialog(errorMessage);
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
//   void _switchAuthMode() {
//     if (_authMode == AuthMode.Login) {
//       setState(() {
//         _authMode = AuthMode.Signup;
//       });
//     } else {
//       setState(() {
//         _authMode = AuthMode.Login;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       elevation: 8,
//       child: Container(
//         height: _authMode == AuthMode.Signup ? 420 : 260,
//         constraints:
//             BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
//         width: deviceSize.width * 0.75,
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Email'),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value.isEmpty || !value.contains('@')) {
//                       return 'Invalid email';
//                     }
//                   },
//                   onSaved: (value) {
//                     _authData['email'] = value;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   controller: _passwordController,
//                   validator: (value) {
//                     if (value.isEmpty || value.length < 6) {
//                       return 'Password is too short';
//                     }
//                   },
//                   onSaved: (value) {
//                     _authData['password'] = value;
//                   },
//                 ),
//                 if (_authMode == AuthMode.Signup)
//                   TextFormField(
//                       enabled: _authMode == AuthMode.Signup,
//                       decoration:
//                           InputDecoration(labelText: 'Confirm Password'),
//                       obscureText: true,
//                       validator: _authMode == AuthMode.Signup
//                           ? (value) {
//                               if (value != _passwordController.text) {
//                                 return 'Password do not match';
//                               }
//                             }
//                           : null),
//                 SizedBox(height: 20),
//                 if (_isLoading)
//                   CircularProgressIndicator()
//                 else
//                   RaisedButton(
//                     child:
//                         Text(_authMode == AuthMode.Login ? 'Login' : 'Signup'),
//                     onPressed: _submit,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 FlatButton(
//                   child: Text(
//                       '${_authMode == AuthMode.Login ? 'Signup' : 'Login'}'),
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
//                   onPressed: _switchAuthMode,
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
