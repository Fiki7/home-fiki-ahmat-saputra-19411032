
import 'dart:async';

import 'package:flutter_app/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const/collor.dart';
import 'package:flutter_app/server/server.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class registerview extends StatefulWidget {
  const registerview({Key? key}) : super(key: key);

  @override
  _registerviewState createState() => _registerviewState();
}

class _registerviewState extends State<registerview> {
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();
  TextEditingController controllernama = new TextEditingController();
  TextEditingController controllertelp = new TextEditingController();

  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> Signup() async {
    var url = UrlServer + "users/sign-up";
    String email = controlleremail.text;
    String nama = controllernama.text;
    String telp = controllertelp.text;
    String password = controllerpassword.text;
    if (email.isEmpty || nama.isEmpty || telp.isEmpty || password.isEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, 'Kolom Tidak Boleh Kosong!', ErrorColor);
    } else {
      final response = await http.post(Uri.parse(url), body: {
        "email": email,
        "nama": nama,
        "telp": telp,
        "password": password
      });
      var result = convert.jsonDecode(response.body);
      String Message = result['message'];
      if (result['status']) {
        Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, SuccesColor);
        print(Message);
        var _duration = const Duration(seconds: 1);
        Timer(_duration, () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => loginview()));
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop();
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
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/login.png')),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Text(
                  'REGISTER',
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
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllertelp,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Telephone',
                    hintText: 'Masukan Nomor Telephone'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllernama,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Nama',
                    hintText: 'Masukan Nama'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    Submit(context);
                  },
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => loginview()));
                },
                child: const Text('Sudah Punya Akun? Masuk'),
              ),
            )
            // Text('Belum Punya Akun? Daftar')
          ],
        ),
      ),
    );
  }

  Future<void> Submit(BuildContext context) async {
    try {
      Signup();
    } catch (error) {
      print(error);
    }
  }
}