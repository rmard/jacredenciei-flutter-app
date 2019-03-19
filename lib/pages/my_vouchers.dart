import 'package:flutter/material.dart';

import '../my_drawer.dart';
import '../api.dart';
import './login.dart';

class MyVouchers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyVouchers();
  }
}

class _MyVouchers extends State<MyVouchers> {
  var vouchers;

  _getOrders() {
    API.getMyVouchers().then((response) {
      setState(() {
        //print('pedidos-loaded');
        //print(response.data);
        vouchers = response.data;
        print(vouchers);
      });
    }).catchError((e) {
      print(e.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => (Login('/vouchers/recebidos'))));
    });
  }

  initState() {
    super.initState();
    _getOrders();
  }

  dispose() {
    super.dispose();
  }

  Widget _body() {
    var ret;
    if (vouchers == null) {
      ret = Center(
        child: Text('Carregando...'),
      );
    } else {
      var v = vouchers['vouchers'];
      print(v);
      List<Widget> list = [];
      for (var i = 0; i < v.length; i++) {
        list.add(cardVoucher(v[i]));
      }
      return ListView(
        children: list,
      );
    }
    return ret;
  }

  Widget cardVoucher(v) {
    var event = v['evento'];
    var imgUrl =
        'https://jacredenciei.com.br/' + event['imagem_dir'] + event['imagem'];
    return Card(
        color: Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(imgUrl),
            ),
            Padding(
              padding: EdgeInsets.all(9),
            ),
            Center(
              child: Text(
                'Voucher ' + v['inscricao']['localizador'].toString(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.indigo),
              ),
            ),
            Center(
              child: Text(
                v['evento']['nome'],
                style: TextStyle(
                    color: Colors.grey[700], fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonBar(
                  children: <Widget>[
                    v['impresso'] == true ?
                    (
                        FlatButton(
                          child: Text('JÁ IMPRESSO'),
                        )
                    )
                        :
                    (
                        RaisedButton(
                          color: Colors.grey[100],
                          child: Text('IMPRIMIR',
                            style: TextStyle(color: Colors.amber[900]),),
                          onPressed: () {
                            API.launchURL(
                                'https://jacredenciei.com.br/vouchers/imprimir/' +
                                    v['id'].toString());
                          },
                        )
                    ),
                    v['email_convidado'] != null ?
                    (
                        FlatButton(
                          child: Text('enviado: ' + v['email_convidado']),
                        )
                    )
                        :
                    (
                        RaisedButton(
                          color: Colors.grey[100],
                          child: Text('ENVIAR PARA CONVIDADO',
                            style: TextStyle(color: Colors.amber[900]),),
                          onPressed: () {
                            showDialog(builder: (context) {
                              return AlertDialog(
                                  title: Text('Em desenvolvimento'),
                                  content: Text(
                                      'Funcionalidade ainda não implementada'));
                            }, context: context

                            );
                          },
                        )
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus vouchers'),
      ),
      drawer: MyDrawer(),
      body: _body(),
    );
  }
}
