import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

const baseUrl = "https://jacredenciei.com.br";

class API {
  static Future getUsers() {
    var url = baseUrl + "/users";
    return http.get(url);
  }

  static Future getOpenedSales() {
    var url = baseUrl + "/pages/home6.json";
    return http.get(url);
  }

  static Future getMyOrders() async {
    Response response;
    Dio dio = new Dio();
    dio.options = BaseOptions(followRedirects: false);
    dio.interceptors.add(CookieManager(CookieJar()));
    try{
      response = await dio.get(baseUrl + "/pedidos/index.json");
      return response;
    } catch(e) {
      throw new Exception("LOGINREQUIRED");
    }
  }

  static Future login(user, pass) async {
    Future<Response> response;
    Dio dio = new Dio();
    dio.options = BaseOptions(followRedirects: false);
    dio.interceptors.add(CookieManager(CookieJar()));
    response = dio.post(baseUrl + "/usuarios/login.json?api=1", data: {"email": user, "senha": pass});
    //.then((r){
      //print(r.data['usuario']);
      //print(CookieJar().loadForRequest(Uri.parse(baseUrl)));
    //});
    return response;
//    response.then((r){
//      print("print: ");
//      print(r.statusCode.toString() );
//    });

    /*
    var client = new http.Client();
    client.post(baseUrl + "/usuarios/login.json",
            body: {"email": user, "senha": pass})
        //.then((response) => client.get(response.b .bodyFields['uri']))
        .then((response) {
      if (response.statusCode == 302) {
        //success
        print(response.headers);
      }
    }).whenComplete(client.close);
    return null;
    */

//    var url = baseUrl + "/pedidos/index.json";
//    final r = new http.Request('GET', Uri.parse(url));
//    r.followRedirects = false;
//    //return http.get(url);
//    return r.send();
  }

  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
