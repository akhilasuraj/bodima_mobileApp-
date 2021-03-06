import 'package:bodima/models/login_model.dart';
import 'package:bodima/scoped_models/main_scope.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthMode _authMode = AuthMode.Login;
  UserMode _userMode = UserMode.Boarder;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'userType': 'boarder',
    'email': null,
    'firstName': null,
    'lastName': null,
    'password': null,
    'address': null,
    'contactNo': null,
  };

  Widget _buildUserTypeToggleButton() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Please select: '),
        SizedBox(
          width: 10.0,
        ),
        RaisedButton(
          color: _userMode == UserMode.Owner ? Colors.teal : Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text('Owner'),
          onPressed: () {
            setState(() {
              _userMode = UserMode.Owner;
              _formData['userType'] = 'owner';
            });
          },
        ),
        SizedBox(
          width: 10.0,
        ),
        RaisedButton(
          color: _userMode == UserMode.Boarder ? Colors.teal : Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text('Boarder'),
          onPressed: () {
            setState(() {
              _userMode = UserMode.Boarder;
              _formData['userType'] = 'boarder';
            });
          },
        ),
        Expanded(
          child: Container(),
        )
      ],
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Email',
        labelText: 'Email',
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Password',
        labelText: 'Password',
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Please enter a valid password';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildFirstNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Password',
        labelText: 'First Name',
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'cannot be empty';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['firstName'] = value;
      },
    );
  }

  Widget _buildLastNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Password',
        labelText: 'Last Name',
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'cannot be empty';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['lastName'] = value;
      },
    );
  }

  Widget _buildAddressTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Password',
        labelText: 'Address',
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Your address contains less than 10 characters';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['address'] = value;
      },
    );
  }

  Widget _buildContactNumberTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Password',
        labelText: 'Contact Number ex: 0712345678',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'please input a contact number';
        } else if (value.length != 10 ||
            !RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$")
                .hasMatch(value)) {
          return 'please input a valid contact number';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        _formData['contactNo'] = value;
      },
    );
  }

  Widget _buildRegisterFormField() {
    return Column(
      children: <Widget>[
        _buildUserTypeToggleButton(),
        Row(
          children: <Widget>[
            Expanded(
              child: _buildFirstNameTextField(),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: _buildLastNameTextField(),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        _buildEmailTextField(),
        SizedBox(
          height: 10.0,
        ),
        _buildPasswordTextField(),
        SizedBox(
          height: 10.0,
        ),
        _buildContactNumberTextField(),
        SizedBox(
          height: 10.0,
        ),
        _buildAddressTextField(),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget _buildLoginFormField() {
    return Column(
      children: <Widget>[
        _buildEmailTextField(),
        SizedBox(
          height: 10.0,
        ),
        _buildPasswordTextField(),
      ],
    );
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print(_formData);
    final successInformation = await authenticate(_formData, _authMode);
    if (successInformation['success'])
      Navigator.pushReplacementNamed(context, '/BoardingFeedPage');
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(' An Error Occured'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
    print(successInformation);
  }

  Widget _buildLoginRegisterButton(MainModel model) {
    return RaisedButton(
      child: Text(
        _authMode == AuthMode.Login ? 'Login' : 'Register',
        style: TextStyle(fontSize: 18.0),
      ),
      color: Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      onPressed: () => _submitForm(model.authenticate),
    );
  }

  Widget _showLogo() {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.asset('assets/user.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
//        decoration: BoxDecoration(
//          image: _buildBackgroundImage(),
//        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          _showLogo(),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _authMode = AuthMode.Login;
                                    });
                                  },
                                  child: Container(
                                    color: _authMode == AuthMode.Login
                                        ? Colors.amber
                                        : Colors.black12,
                                    child: SizedBox(
                                      height: 40.0,
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: _authMode == AuthMode.Login
                                              ? TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold)
                                              : TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _authMode = AuthMode.Register;
                                    });
                                  },
                                  child: Container(
                                    color: _authMode == AuthMode.Register
                                        ? Colors.amber
                                        : Colors.black12,
                                    child: SizedBox(
                                      height: 40.0,
                                      child: Center(
                                        child: Text(
                                          'Register',
                                          style: _authMode == AuthMode.Register
                                              ? TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold)
                                              : TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.amber,
                            height: 3.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _authMode == AuthMode.Login
                              ? _buildLoginFormField()
                              : _buildRegisterFormField(),
                          SizedBox(
                            height: 10.0,
                          ),
                          ScopedModelDescendant<MainModel>(
                            builder: (BuildContext context, Widget child,
                                MainModel model) {
                              return model.isLoading
                                  ? CircularProgressIndicator()
                                  : _buildLoginRegisterButton(model);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
