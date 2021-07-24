import 'package:examen/dataDB/rest_data.dart';
import 'package:examen/models/user.dart';

abstract class LoginValidated {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginPresenter {
  LoginValidated _view;
  RestData api = new RestData();
  LoginPresenter(this._view);

  dynamic doLogin(String username, String password) {
    api
        .login(username, password)
        .then((user) => _view.onLoginSuccess(user))
        .catchError((onError) => _view.onLoginError(onError));
  }
}
