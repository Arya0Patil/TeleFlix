import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFN, this.isLoading);
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFN;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userId = '';
  var _userPass = '';
  var _userName = '';

  void _submit() async {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFN(
        _userId.trim(),
        _userPass.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );

      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: Center(
        child: Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.com')) {
                          return 'Email not valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: Colors.purple)),
                      ),
                      onSaved: (value) {
                        _userId = value;
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    if (!_isLogin)
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.length < 5) {
                            return 'Enter atleast 5 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Choose Username',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.purple)),
                        ),
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password should be 7 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      obscureText: true,
                      onSaved: (value) {
                        _userPass = value;
                      },
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                          onPressed: (_submit),
                          child: Text(_isLogin ? 'Login' : 'SignUp')),
                    if (!widget.isLoading)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'Already have an account'),
                      ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
