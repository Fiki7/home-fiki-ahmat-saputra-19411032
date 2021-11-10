import 'dart:async';

import 'package:flutter_app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/register.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_app/const/collor.dart';
import 'package:flutter_app/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginview extends StatefulWidget {
  const loginview({Key? key}) : super(key: key);

  @override
  _loginviewState createState() => _loginviewState();
}

class _loginviewState extends State<loginview> {
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();

  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> Signin() async {
    String email = controlleremail.text;
    String password = controllerpassword.text;
    var url = UrlServer + "users/sign-in";
    if (email.isEmpty) {
      // Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, 'Email Tidak Boleh Kosong !', ErrorColor);
    } else if (password.isEmpty) {
      showSnakbar(context, 'Password Tidak Boleh Kosong !', ErrorColor);
    } else {
      final response = await http
          .post(Uri.parse(url), body: {"email": email, "password": password});
      var result = convert.jsonDecode(response.body);
      print(result);
      String Message = result['message'];
      if (result['status']) {
        // Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, SuccesColor);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogin', true);
        await prefs.setString('_id', result['user']['_id']);
        await prefs.setString('nama', result['user']['nama']);
        await prefs.setString('email', result['user']['email']);
        await prefs.setString('telp', result['user']['telp']);
        await prefs.setString('password', result['user']['password']);
        var _duration = const Duration(seconds: 1);
        Timer(_duration, () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => homepage()));
        });
      } else {
        // Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, ErrorColor);
        print(Message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 15),
              child: Center(
                child: Container(
                    width: 150,
                    height: 150,
                    // decoration: BoxDecoration(
                    //     color: Colors.red,
                    //     borderRadius: BorderRadius.circular(50.0)),
                    child: Image.asset('assets/login.png')),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Text(
                  'Masuk',
                  style: (TextStyle(
                      color: Colors.blue, fontSize: 25, fontFamily: 'Raleway')),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controlleremail,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Email',
                    hintText: 'Masukan Email'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                  controller: controllerpassword,
                  autofocus: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      labelText: 'Password',
                      hintText: 'Masukan Password'),
                  obscureText: true),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              // padding: EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 20.0),
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  Submit(context);
                },
                child: const Text(
                  'LOG IN',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => registerview()));
                },
                child: const Text(
                  'Belum Punya Akun? Daftar',
                  style: TextStyle(color: Colors.green, fontSize: 15),
                )),
            // Text('Belum Punya Akun? Daftar')
          ],
        ),
      ),
    );
  }

  Future<void> Submit(BuildContext context) async {
    try {
      Signin();
    } catch (error) {
      print(error);
    }
  }
}