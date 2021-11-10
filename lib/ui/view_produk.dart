import 'dart:io';

import 'package:flutter_app/server/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdukView extends StatelessWidget {
  final String apiUrl = UrlServer + "produk/get";
  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    List<dynamic>? fecthDataProduk;
  }

  Future<List<dynamic>> getLists() async {
    var response = await http.get(Uri.parse(apiUrl));
    try {
      var decodedResponse = json.decode(response.body)['data'];
      print(decodedResponse);
      return decodedResponse;
    } on SocketException catch (_) {}
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk Anda'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: getLists(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: Image.asset('assets/sepatu.jpg'),
                              // child: Image.network("http://pasar.pptik.id/" +
                              //     snapshot.data[index]['IMAGE']),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 25.0, 10.0, 10.0),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index]['merk'],
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  subtitle: Text("Ukuran:" +
                                      snapshot.data[index]['size'] +
                                      "" +
                                      "            " +
                                      "deskripsi:" +
                                      snapshot.data[index]['deskripsi'] +
                                      "" +
                                      "            " +
                                      "warna:" +
                                      snapshot.data[index]['warna']),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}