import "package:flutter/material.dart";
import 'dart:convert';
import '../api.dart';
import '../widgets/card_event.dart';
import '../my_drawer.dart';
import 'my_orders.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<HomePage> {
  var sales = [];
  var loading = true;

  _getSales() {
    API.getOpenedSales().then((response) {
      setState(() {
        loading = false;
        //print(response.body);
        Map<String, dynamic> list = json.decode(response.body);
//        print('List: ');
//        print(list.toString());
        sales = list['vabertas'];
        //Map<String, dynamic> vabertas = json.decode(list['vabertas']);
        //print('VAbertas: ');
        //print(list['vabertas']);
        //sales = list.map((model) => User.fromJson(model)).toList();
        //sales = list.map((model) => model.toList());
      });
    });
  }

  initState() {
    super.initState();
    _getSales();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: MyDrawer(),
        body: loading
            ? new LinearProgressIndicator()
            : Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: sales.map((sale) => (CardEvent(sale))).toList(),
                    )
                  ],
                ),
              ));
  }
}
