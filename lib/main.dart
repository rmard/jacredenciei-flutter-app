import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import './pages/home.dart';
import './pages/my_orders.dart';
import './pages/my_vouchers.dart';

void main() => runApp(MyApp());

class MySplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 6,
      navigateAfterSeconds: HomePage(title: 'JáCredenciei'),
      backgroundColor: Colors.indigo[700],
      loaderColor: Colors.amber,
      image: Image.asset('assets/logosplash.png'),
      photoSize: 175,
      gradientBackground: LinearGradient(
        colors: [Colors.indigo, Colors.indigoAccent],
      ),
      loadingText: Text(
        'Carregando...',
        style: TextStyle(color: Colors.indigo[100]),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.indigo[700],
        accentColor: Colors.amber,
      ),
      //home: MySplash(),
      initialRoute: '/splash',
      routes: {
        '/': (context) => HomePage(title: 'JáCredenciei'),
        '/splash': (context) => MySplash(),
        '/pedidos': (context) => MyOrders(),
        '/vouchers/recebidos': (context) => MyVouchers(),
      },
    );
  }
}
