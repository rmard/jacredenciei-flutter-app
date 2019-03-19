import 'package:flutter/material.dart';
import 'dart:convert';

import './login.dart';
import '../my_drawer.dart';
import '../api.dart';

class MyOrders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyOrdersState();
  }
}

class _MyOrdersState extends State<MyOrders> {
  //Map<String, dynamic> orders = null;
//  Map<String, dynamic> orders = null;
  var orders;

  _getOrders() {
    API.getMyOrders().then((response) {
      setState(() {
        print('pedidos-loaded');
        //print(response.data);
        orders = response.data;
      });
    }).catchError((e) {
      print(e.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (Login('/pedidos'))));
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
    if (orders == null) {
      ret = Center(
        child: Text('Carregando...'),
      );
    } else {
      var ped = orders['pedidos'];
      print(ped);
      List<Widget> list = [];
      for (var i = 0; i < ped.length; i++) {
        list.add(cardPedido(ped[i]));
      }
      return ListView(
        children: list,
      );
    }
    return ret;
  }

  Widget cardPedido(ped) {
    var _chip = Chip(
        backgroundColor: Colors.grey[300],
        label: Text(
          'Pago',
          style: TextStyle(color: Colors.green),
        ));
    if (ped['dt_pgto'] == null)
      _chip = Chip(
          backgroundColor: Colors.grey[300],
          label: Text(
            'Pendente',
            style: TextStyle(color: Colors.orange),
          ));
    if (ped['cancelado'] == true)
      _chip = Chip(
          backgroundColor: Colors.grey[300],
          label: Text(
            'Cancelado',
            style: TextStyle(color: Colors.red),
          ));

    return Card(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Pedido #' + ped['id'].toString(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _chip,
                ],
              ),
            ],
          ),
          Text(
            ped['inscricoes'][0]['evento']['nome'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
          Padding(padding: EdgeInsets.only(bottom: 5),),
          Text(ped['inscricoes'].length.toString() + ' inscriç' +
              (ped['inscricoes'].length == 1 ? 'ão' : 'ões')),
          Text('R\$ ' + ped['valor'].toString()),
          Padding(padding: EdgeInsets.only(bottom: 5),),
          Divider(),
          Row(
            children: [FlatButton(
              child: Text('ABRIR', style: TextStyle(color: Colors.amber[700]),),
              onPressed: () {
                API.launchURL("https://jacredenciei.com.br/pedidos/view/"+ped['id'].toString());
              },)
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
      margin: EdgeInsets.only(bottom: 20),
    );
    return Text('id: ' + ped['dt_pgto'].toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
      ),
      drawer: MyDrawer(),
      body: _body(),
    );
  }
}
