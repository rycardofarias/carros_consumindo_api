
import 'dart:ffi';

import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/loginBloc.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/response_api.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app.text.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = Login_Bloc();

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  bool _showProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(
      ),
    );
  }

  _body() {

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText("Login", "Digite o login",
                controller: _tLogin, validator: _validatorLogin,
              keyboarType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha
            ),
            SizedBox(height: 10),
            AppText("Senha", "Digite a senha", passoword: true,
                controller: _tSenha, validator: _validatorSenha,
              keyboarType: TextInputType.number,
              focusNode: _focusSenha
            ),
            SizedBox(height: 10,),
              StreamBuilder<bool>(
                stream: _bloc.Stream,
                initialData: false,
                builder: (context, snapshot){


                  return
                    AppButton("Login", onPressed: _onClickLogin,
                      showProgress: _showProgress,
                    );
                  },
              )
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async{
    bool formOk = _formKey.currentState.validate();
    if(!formOk){
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    print("Login: $login, Senha: $senha");

    setState((){
      _showProgress = true;
    });

    ApiResponse response = await LoginApi.login(login, senha);

    if(response.ok){
      Usuario user = response.result;
      //print(">>> $response");
      push(context, HomePage(), replace : true);
    }else{
      alert(context, response.msg);
    }
    setState((){
      _showProgress = false;
    });
  }

  String _validatorLogin(String text) {
    if(text.isEmpty){
      return "Digite o login";
    }
    return null;
  }

  String _validatorSenha(String text) {
    if(text.isEmpty){
      return "Digite a senha";
    }
    if(text.length<3){
      return "A senha possui poucos caracteres";
    }
    return null;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }
}
