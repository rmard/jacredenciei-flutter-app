import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';

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

  static Future getMyVouchers() async {
    Response response;
    Dio dio = new Dio();
    dio.options = BaseOptions(followRedirects: false);
    dio.interceptors.add(CookieManager(CookieJar()));
    try{
      response = await dio.get(baseUrl + "/vouchers/recebidos.json");
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
    return response;
  }

  static Future sendVoucher(id, email, name) async {
    Future<Response> response;
    Dio dio = new Dio();
    dio.options = BaseOptions(followRedirects: false);
    dio.interceptors.add(CookieManager(CookieJar()));
    response = dio.post(baseUrl + "/vouchers/enviaremail/"+id.toString()+".json?api=1", data: {"email_convidado": email, "nome_convidado": name});
    return response;
  }

  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
