import 'package:flutter/material.dart';
import 'dart:async';

import '../api.dart';

class Login extends StatefulWidget {
  var redirectTo;
  Login(this.redirectTo);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Login();
  }
}

class _Login extends State<Login> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    emailController.text = 'rmardn@gmail.com';
    final passwordController = TextEditingController();
    final passwordFocusNode = FocusNode();

    @override
    void dispose() {
      // Clean up the controller when the Widget is disposed
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    void _submit(context) {
      print(passwordController.text);
      // Validate will return true if the form is valid, or false if
      // the form is invalid.
      if (_formKey.currentState.validate()) {
        // If the form is valid, we want to show a Snackbar
//        Scaffold.of(context).showSnackBar(
//            SnackBar(content: Text('Login ainda será implementado...')));
        API.login(emailController.text, passwordController.text).then((response){
          //print(response);

          if(response.data['usuario']==false) {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Email e/ou senha inválido(s). Tente novamente.')));
          }
          else {
            Navigator.pushNamedAndRemoveUntil(context, widget.redirectTo, (_)=>false);
          }

        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Builder(
        builder: (context) {
//          Timer(Duration(seconds: 1), () {
//            Scaffold.of(context).showSnackBar(
//                SnackBar(content: Text('Efetue login para prosseguir!')));
//          });
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (term){
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Esse campo é obrigatório';
                      }
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    onFieldSubmitted: (term){
                      _submit(context);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Esse campo é obrigatório';
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        _submit(context);
                      },
                      child: Text('ENTRAR'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: FlatButton(
                        onPressed: () => {
                        API.launchURL(
                        "https://jacredenciei.com.br/usuarios/add")
                    },
                        textColor: Colors.indigo,
                        child: Text('Criar uma conta')
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
