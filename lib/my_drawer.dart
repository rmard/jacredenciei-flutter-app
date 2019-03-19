import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget{
  //final drawerNavigate;
  //MyDrawer({this.drawerNavigate});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10),),
                Image.asset('assets/logosplash.png'),
                Padding(padding: EdgeInsets.all(10),),
                Text('VERSÃO 0.20190319', style: TextStyle(color: Colors.indigo[300], fontSize: 12),),

              ],
            ),
            decoration: BoxDecoration(
              color: Colors.indigo[700],
            ),
          ),
          ListTile(
            title: Text('Novo pedido'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (_)=>false);
            },
          ),
          ListTile(
            title: Text('Meus pedidos'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/pedidos', (_)=>false);
            },
          ),
          ListTile(
            title: Text('Meus vouchers'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/vouchers/recebidos', (_)=>false);
            },
          ),
        ],
      ),
    );
  }
}