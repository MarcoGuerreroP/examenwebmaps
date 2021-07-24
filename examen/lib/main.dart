import 'package:examen/ui/pages/form_page.dart';
import 'package:examen/ui/pages/login_page.dart';
import 'package:examen/ui/pages/register_page.dart';
import 'package:examen/ui/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WebApps',
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          '/login': (BuildContext ctx) => LoginPage(),
          '/form': (BuildContext context) => FormPage(),
          '/register': (BuildContext context) => RegisterPage(),
          '/welcome': (BuildContext context) => WelcomePage(),
        });
  }
}
