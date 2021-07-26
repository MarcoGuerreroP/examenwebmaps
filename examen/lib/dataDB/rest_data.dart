import 'dart:async';
import 'package:examen/dataDB/database_helper.dart';
import 'package:examen/models/user.dart';

class RestData {
  // // ignore: non_constant_identifier_names
  // static final BASE_URL = "";
  // // ignore: non_constant_identifier_names
  // static final LOGIN_URL = BASE_URL + "/";

  Future<User> login(String username, String password) async {
    String flagLogged = "logged";

    var user = new User(username, password, null);
    // var db = new DatabaseHelper();
    var userRetorno = new User(
      null,
      null,
      null,
    );
    userRetorno = await DatabaseHelper.database.selectUser(user);
    if (userRetorno != null) {
      flagLogged = "logged";
      return new Future.value(new User(username, password, flagLogged));
    } else {
      flagLogged = "not";
      return new Future.value(new User(username, password, flagLogged));
    }
  }
}
