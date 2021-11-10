import 'package:flutter_app/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String namaLengkap = "", email = "", noTelp = "";
  final _globalKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController namaLengkapController = new TextEditingController();
  TextEditingController alamatController = new TextEditingController();
  TextEditingController noTelpController = new TextEditingController();

  TextEditingController passwordOldController = new TextEditingController();
  TextEditingController passwordNewController = new TextEditingController();
  TextEditingController passwordRepeatController = new TextEditingController();
  Future<void> Logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  void getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getInt('telp').toString());

    setState(() {
      namaLengkap = sharedPreferences.getString('nama').toString();
      noTelp = sharedPreferences.getString('telp').toString();
      email = sharedPreferences.getString('email').toString();
      namaLengkapController.text = namaLengkap;
      emailController.text = email;
      noTelpController.text = noTelp;
    });
  }

  void updateProfile() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var url = masterurl + 'updateprofile/' + sharedPreferences.getString('id');

    // final response = await http.post(url, body: {
    //   "email": emailController.text,
    //   "namaLengkap": namaLengkapController.text,
    //   "alamat": alamatController.text,
    //   "noTelp": noTelpController.text,
    // });

    // Navigator.pop(context);

    // var result = json.decode(response.body);
    // if (result['sukses']) {
    //   sharedPreferences.setString("email", emailController.text);
    //   sharedPreferences.setString("namaLengkap", namaLengkapController.text);
    //   sharedPreferences.setString("alamat", alamatController.text);
    //   sharedPreferences.setString("noTelp", noTelpController.text);
    //   this.getProfile();
    //   showSnackbar(context, result['msg'], suksesColor);
    // } else {
    //   showSnackbar(context, result['msg'], dangerColor);
    // }
  }

  final _updateProfileKey = GlobalKey<FormState>();
  _displayUpdateProfile(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ListView(
            children: <Widget>[
              Form(
                key: _updateProfileKey,
                child: AlertDialog(
                  elevation: 0.0,
                  title: const Text('Ubah Profile'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mohon Isi E-Mail";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "E-Mail", labelText: "E-Mail"),
                      ),
                      TextFormField(
                        controller: namaLengkapController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mohon Isi Nama Lengkap";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Nama Lengkap",
                            labelText: "Nama Lengkap"),
                      ),
                      TextFormField(
                        controller: alamatController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mohon Isi Alamat";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Alamat", labelText: "Alamat"),
                      ),
                      TextFormField(
                        controller: noTelpController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mohon Isi No Telp";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "No Telp", labelText: "No Telp"),
                      )
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: const Text('Batal'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: new Text('Update Data'),
                      onPressed: () {
                        if (_updateProfileKey.currentState!.validate()) {
                          updateProfile();
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  final _changePasswordKey = GlobalKey<FormState>();
  _displayChangePassword(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              Form(
                key: _changePasswordKey,
                child: AlertDialog(
                  elevation: 0.0,
                  title: Text('Ganti password'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mohon Isi Password Baru";
                          }
                          return null;
                        },
                        controller: passwordOldController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "Password Lama Anda",
                            labelText: "Password Lama Anda"),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mohon Isi Password Lama";
                          }
                          return null;
                        },
                        controller: passwordNewController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "Password Baru",
                            labelText: "Password Baru"),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ketik Ulang Password Dengan Benar";
                          } else if (value != passwordNewController.text) {
                            return 'Ketik Ulang Password Dengan Benar';
                          }
                          return null;
                        },
                        controller: passwordRepeatController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "Ketik Ulang Password Baru",
                            labelText: "Ketik Ulang Password Baru"),
                      )
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text('Batal'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: new Text('Update Data'),
                      onPressed: () {
                        if (_changePasswordKey.currentState!.validate()) {
                          changePassword();
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  void changePassword() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var url = masterurl + 'changepassword/' + sharedPreferences.getString('id');

    // final response = await http.post(url, body: {
    //   "oldPassword": passwordOldController.text,
    //   "newPassword": passwordNewController.text,
    // });

    // setState(() {
    //   passwordNewController.text = '';
    //   passwordOldController.text = '';
    //   passwordRepeatController.text = '';
    // });

    // Navigator.pop(context);

    // var result = json.decode(response.body);
    // if (result['sukses']) {
    //   showSnackbar(context, result['msg'], suksesColor);
    // } else {
    //   showSnackbar(context, result['msg'], dangerColor);
    // }
  }

  void showSnackbar(BuildContext context, msg, color) {
    final snackBar = SnackBar(content: Text(msg), backgroundColor: color);
    _globalKey.currentState!.showSnackBar(snackBar);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          title: const Text('Profile', style: TextStyle(color: Colors.white))),
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(left: 15.0, bottom: 20.0, top: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 40,
                        child: Icon(
                          Icons.perm_identity,
                          size: 50.0,
                          color: Colors.black,
                        )),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          namaLengkap,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(Icons.email),
                            Text(
                              email,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(Icons.call),
                            const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                            ),
                            Text(
                              noTelp,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ButtonTheme(
                      minWidth: 150.0,
                      height: 45.0,
                      child: GestureDetector(
                        onTap: () {
                          _displayUpdateProfile(context);
                        },
                        child: Container(
                          width: 150.0,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5.0)),
                          alignment: Alignment.center,
                          child: const Text(
                            'Ubah Profil',
                            style: TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ))),
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ButtonTheme(
                      minWidth: 150.0,
                      height: 45.0,
                      child: GestureDetector(
                        onTap: () {
                          _displayChangePassword(context);
                        },
                        child: Container(
                          width: 150.0,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5.0)),
                          alignment: Alignment.center,
                          child: const Text(
                            'Ganti Password',
                            style: TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      )))
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20.0)),
          Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ButtonTheme(
                  minWidth: 400.0,
                  height: 45.0,
                  child: GestureDetector(
                    onTap: () {
                      Logout();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  loginview()));
                    },
                    child: Container(
                      width: 200.0,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0)),
                      alignment: Alignment.center,
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ))),
          const Padding(padding: EdgeInsets.only(top: 20.0)),
        ],
      ),
    );
  }
}