// import 'package:email_validator/email_validator.dart';
import 'package:examen/dataDB/database_helper.dart';
import 'package:examen/models/user.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailUserController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  // ignore: unused_field

  // ignore: unused_field
  bool _isLoading = false;
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String title = 'Sign Up';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: _scaffoldKey,
      child: Scaffold(
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
                labelSignUp(),
                SizedBox(height: 20.0),
                labelUser(),
                SizedBox(height: 20.0),
                labelPassword(),
                SizedBox(height: 40.0),
                buttonSesion(),
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

  Widget labelSignUp() {
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
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Enter pass',
          border: OutlineInputBorder(),
        ),
        onSaved: (value) => setState(() => _passwordController.text = value),
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
        child: Text('register'),
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

  void _showSnackBar(String message, Color color) {
    // String message = "";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        var user = new User(_emailUserController.text.trim(),
            _passwordController.text.trim(), null);

        DatabaseHelper.database.saveUser(user);
        _isLoading = false;
        Navigator.of(context).pushNamed("/login");
        _showSnackBar("Created successful", Colors.green);
      });
    }
  }
}
