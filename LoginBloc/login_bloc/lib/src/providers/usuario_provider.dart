import 'package:login_bloc/src/user_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyDHRVwPoGKDnFosaGXmgYUiwq8ErRNx7Rw';
  final _prefs = new UserPreferences();

  Future login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final res = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData),
    );

    Map decodedRes = json.decode(res.body);

    // print(decodedRes);

    if (decodedRes.containsKey('idToken')) {
      _prefs.token = decodedRes['idToken'];
      return {'ok': true, 'token': decodedRes['idToken']};
    } else {
      return {'ok': false, 'message': decodedRes['error']['message']};
    }
  }

  Future newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final res = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData),
    );

    Map decodedRes = json.decode(res.body);

    // print(decodedRes);

    if (decodedRes.containsKey('idToken')) {
      _prefs.token = decodedRes['idToken'];
      return {'ok': true, 'token': decodedRes['idToken']};
    } else {
      return {'ok': false, 'message': decodedRes['error']['message']};
    }
  }
}
