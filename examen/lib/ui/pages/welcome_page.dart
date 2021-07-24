// import 'dart:async';

import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void initState() {
    super.initState();

    // Timer(Duration(seconds: 5),
    //     () => Navigator.pushReplacementNamed(context, '/form'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _imgWelcome(context),
          _textWelcome(),
          _labelWelcomeStore(context),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _imgWelcome(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Container(
      // width: size.width * 100,
      // margin: EdgeInsets.symmetric(vertical: 1.0),
      // padding: EdgeInsets.symmetric(vertical: 50.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          colors: <Color>[
            Color(0xFFF7F7F7),
            Color(0xFFF7F7F7),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage('assets/img/webmaps.png'),
              height: 180.0,
              width: 200.0,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }

  Widget _labelWelcomeStore(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: Color(0xFF3134E4),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              ' Loading ...............',
              softWrap: true,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
  }
}

_textWelcome() {
  return Center(
    child: Container(
      color: Colors.grey,
      width: 100,
      height: 200,
      child: Text("Welcome", style: TextStyle(fontSize: 20)),
    ),
  );
}
