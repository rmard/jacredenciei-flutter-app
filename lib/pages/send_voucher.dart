import 'package:flutter/material.dart';

import '../api.dart';

class SendVoucher extends StatefulWidget {
  final v;

  SendVoucher(this.v);

  @override
  State<StatefulWidget> createState() {
    return _SendVoucher();
  }
}

class _SendVoucher extends State<SendVoucher> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final passwordFocusNode = FocusNode();
    var event = widget.v['evento'];
    var imgUrl =
        'https://jacredenciei.com.br/' + event['imagem_dir'] + event['imagem'];

    void _submit(context) {
      // Validate will return true if the form is valid, or false if
      // the form is invalid.
//      if (Form.of(context).validate()) {
      if (_formKey.currentState.validate()) {
          API.sendVoucher(widget.v['id'], emailController.text, nameController.text).then((response){
            Navigator.pushNamedAndRemoveUntil(context, '/vouchers/recebidos', (_)=>false);
          });
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Voucher ' + widget.v['inscricao']['localizador'])
      ),
      body: Builder(
        builder: (context) {
//          Timer(Duration(seconds: 1), () {
//            Scaffold.of(context).showSnackBar(
//                SnackBar(content: Text('Efetue login para prosseguir!')));
//          });
          return ListView(
              children: [
                Image(
                  image: NetworkImage(imgUrl),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context).requestFocus(
                                passwordFocusNode);
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: 'Email do convidado',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Esse campo é obrigatório';
                            }
                          },
                        ),
                        TextFormField(
                          controller: nameController,
                          focusNode: passwordFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Nome do convidado',
                          ),
                          onFieldSubmitted: (term) {
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
                            child: Text('ENVIAR'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]
          );
        },
      ),
    );

    return Scaffold(
        appBar: AppBar(
            title: Text('Voucher ' + widget.v['inscricao']['localizador'])),
        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Image(
                image: NetworkImage(imgUrl),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Enviar voucher por email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Form(
                    //key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: 'email'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        }));
  }
}
