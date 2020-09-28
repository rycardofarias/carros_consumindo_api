import 'dart:async';

import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

import '../response_api.dart';

class Login_Bloc{

  final _streamController = StreamController<bool>();
  get Stream => _streamController.stream;

  Future<ApiResponse<Usuario>> login(String login, String senha) async{

    ApiResponse response = await LoginApi.login(login, senha);

    return response;
  }
  void dispose(){
    _streamController.close();
  }
}