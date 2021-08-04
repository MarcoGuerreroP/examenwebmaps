import 'package:examen/models/user.dart';
import 'package:examen/utils/login_presenter.dart';
import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginValidated {
  // ignore: unused_field
  bool _isLoading = false;

  TextEditingController _emailUserController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final String title = 'Sign in';
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  LoginPresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPresenter(this);
  }
  void _register() {
    Navigator.of(context).pushNamed("/register");
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = false;
        form.save();
        _presenter.doLogin(_emailUserController.text.trim(), _passwordController.text.trim());
      });
    }
  }

  void _showSnackBar(String message, Color color) {
    // String message = "";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.0),
                    logo(),
                    SizedBox(height: 20.0),
                    labelSignIn(),
                    SizedBox(height: 20.0),
                    labelUser(),
                    SizedBox(height: 20.0),
                    labelPassword(),
                    SizedBox(height: 40.0),
                    buttonSesion(),
                    SizedBox(height: 20.0),
                    buttonRegister(),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget logo() {
    return Image.asset(
      'assets/img/webmaps.png',

      // height: 250.0,
    );
  }

  Widget labelSignIn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Text(
        title,
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget labelUser() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      child: TextFormField(
        validator: (value) {
          final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);

          if (value.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
        controller: _emailUserController,
        decoration: InputDecoration(
          labelText: 'User or Email',
          hintText: 'Enter email',
          border: OutlineInputBorder(),
        ),
        onSaved: (value) => setState(() => _emailUserController.text = value),
      ),
    );
  }

  Widget labelPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a valid password';
          } else if (value.length != 8) {
            return 'Please the pass is 8 characters';
          } else {
            return null;
          }
        },
        controller: _passwordController,
        onSaved: (value) => setState(() => _passwordController.text = value),
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Enter pass',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buttonSesion() {
    return Container(
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          _submit();
        },
        child: Text('login'),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          textStyle: TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
      ),
    );
  }

  buttonRegister() {
    return Container(
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: _register,
        child: Text('register'),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          textStyle: TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
      ),
    );
  }

  @override
  void onLoginSuccess(User user) {
    if (user.username.isEmpty) {
      _showSnackBar("the fields are empty try again", Colors.orange);
      Navigator.of(context).pushNamed("/login");
    }
    setState(() {
      _isLoading = false;
    });
    if (user.flaglogged == "logged") {
      print("Logged");
      _showSnackBar("Login is successful", Colors.blue);
      Navigator.of(context).pushNamed("/welcome");
    } else {
      print("Not Logged");
      _showSnackBar("Login not successful dont have exit User", Colors.red);
      Navigator.of(context).pushNamed("/register");
    }
  }

  @override
  void onLoginError(String error) {
    _showSnackBar("Login not successful", Colors.red);
    setState(() {
      _isLoading = false;
    });
  }
}
