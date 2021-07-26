import 'package:examen/ui/pages/addpeople.dart';
import 'package:examen/ui/pages/form_page.dart';
import 'package:examen/ui/pages/login_page.dart';
import 'package:examen/ui/pages/pagina.dart';
import 'package:examen/ui/pages/register_page.dart';
import 'package:examen/ui/pages/welcome_page.dart';
import 'package:examen/ui/sort_pages/getcountrypage.dart';
import 'package:examen/ui/sort_pages/getgenerpage.dart';
import 'package:examen/ui/sort_pages/getstatepage.dart';
import 'package:examen/ui/sort_pages/getuserpage.dart';
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
          '/page': (BuildContext ctx) => PagePrueba(),
          '/form': (BuildContext context) => FormPage(),
          '/register': (BuildContext context) => RegisterPage(),
          '/welcome': (BuildContext context) => WelcomePage(),
          '/addpeople': (BuildContext context) => AddPeoplePage(),
          '/getUser': (BuildContext context) => GetUserPage(),
          '/getCountry': (BuildContext context) => GetCountryPage(),
          '/getState': (BuildContext context) => GetStatePage(),
          '/getGener': (BuildContext context) => GetGenerPage(),
        });
  }
}
