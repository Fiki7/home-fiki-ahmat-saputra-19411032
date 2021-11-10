// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
//
//
// class ImageUpload extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ImageUpload();
//   }
// }
//
// class _ImageUpload extends State<ImageUpload> {
//   File? uploadimage;
//   List<XFile>? _imageFileList;
//   dynamic _pickImageError;
//
//   set _imageFile(XFile? value) {
//     _imageFileList = value == null ? null : [value];
//   }
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> chooseImage() async {
//     // var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
//     //set source: ImageSource.camera to get image from camera
//     // final image = await _picker.pickImage(source: ImageSource.gallery);
//     // setState(() {
//     //   // uploadimage = image ;
//     //   _imageFileList = image as List<XFile>?;
//     // });
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       setState(() {
//         _imageFile = pickedFile;
//         // uploadimage=pickedFile as File?;
//       });
//     } catch (e) {
//       setState(() {
//         _pickImageError = e;
//       });
//     }
//   }
//
//   Future<void> uploadImage() async {
//     //show your own loading or progressing code here
//
//     String uploadurl = "http://192.168.100.28:5000/img/upload";
//     //dont use http://localhost , because emulator don't get that address
//     //insted use your local IP address or use live URL
//     //hit "ipconfig" in windows or "ip a" in linux to get you local IP
//
//     try {
//       List<int> imageBytes = uploadimage!.readAsBytesSync();
//       String baseimage = base64Encode(imageBytes);
//       //convert file image to Base64 encoding
//       var response = await http.post(Uri.parse(uploadurl), body: {
//         'file': baseimage,
//       });
//       // if (response.statusCode == 200) {
//       //   var jsondata = json.decode(response.body); //decode json data
//       //   if (jsondata["error"]) {
//       //     //check error sent from server
//       //     print(jsondata["msg"]);
//       //     //if error return from server, show message from server
//       //   } else {
//       //     print("Upload successful");
//       //   }
//       // } else {
//       //   print("Error during connection to server");
//       //   //there is error during connecting to server,
//       //   //status code might be 404 = url not found
//       // }
//     } catch (e) {
//       print("Error during converting to Base64");
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//   Widget _previewImages() {
//     // final Text? retrieveError = _getRetrieveErrorWidget();
//     // if (retrieveError != null) {
//     //   return retrieveError;
//     // }
//     if (_imageFileList != null) {
//       return Semantics(
//           child: ListView.builder(
//             key: UniqueKey(),
//             itemBuilder: (context, index) {
//               // Why network for web?
//               // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
//               uploadimage=_imageFileList![index].path as File?;
//               return Semantics(
//                 label: 'image_picker_example_picked_image',
//                 child: kIsWeb
//                     ? Image.network(_imageFileList![index].path)
//                     : Image.file(File(_imageFileList![index].path)),
//               );
//             },
//             itemCount: _imageFileList!.length,
//           ),
//           label: 'image_picker_example_picked_images');
//     } else if (_pickImageError != null) {
//       return Text(
//         'Pick image error: $_pickImageError',
//         textAlign: TextAlign.center,
//       );
//     } else {
//       return const Text(
//         'You have not yet picked an image.',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Tambah Produk"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Container(
//         height: 300,
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment:
//               MainAxisAlignment.center, //content alignment to center
//           children: <Widget>[
//             // ``Expanded(
//             //  //  child:_imageFileList == null?
//             //  // Container():
//             //   child: SizedBox(
//             //     height: 200.0,
//             //     child: ListView.builder(
//             //       scrollDirection: Axis.horizontal,
//             //       // itemCount: products.length,
//             //       itemBuilder: (BuildContext ctxt, int index) {
//             //         return Semantics(
//             //           label: 'image_picker_example_picked_image',
//             //           child: kIsWeb
//             //               ? Image.network(_imageFileList![index].path)
//             //               : Image.file(File(_imageFileList![index].path)),
//             //         );
//             //         // return new Text(products[index]);
//             //       },
//             //     ),
//             //   ),
//             // ),``
//             SizedBox(
//               // height: MediaQuery.of(context).size.height / 10,
//               // width: MediaQuery.of(context).size.height / 10,
//               height: 200.0,
//               width: 200.0,
//               child: _imageFileList == null
//                   ? Container()
//                   : ListView.builder(
//                       // scrollDirection: Axis.horizontal,
//                       itemCount: _imageFileList!.length.compareTo(0),
//                       itemBuilder: (context, index) {
//                         return Semantics(
//                           // label: 'image_picker_example_picked_image',
//                           // child: kIsWeb
//                           // ? Image.network(_imageFileList![index].path)
//                           //     :
//                           //   pri
//                           //   if(){}
//                           child: Image.file(File(_imageFileList![index].path)),
//                         );
//                       },
//                     ),
//               // child: _previewImages(),//show image here after choosing image
//               //   height: 200.0,
//             ),
//
//             //if uploadimage is null then show empty container
//             // Container(   //elese show image here
//             //     child: SizedBox(
//             //         height:150,
//             //         child:Image.file() //load image from file
//             //     )
//             // )
//             // ),
//             //
//
//             Container(
//                 //show upload button after choosing image
//                 child: uploadimage == null
//                     ? Container()
//                     : //if uploadimage is null then show empty container
//                     Container(
//                         //elese show uplaod button
//                         child: RaisedButton.icon(
//                         onPressed: () {
//                           uploadImage();
//                           //start uploading image
//                         },
//                         icon: Icon(Icons.file_upload),
//                         label: Text("UPLOAD IMAGE"),
//                         color: Colors.deepOrangeAccent,
//                         colorBrightness: Brightness.dark,
//                         //set brghtness to dark, because deepOrangeAccent is darker coler
//                         //so that its text color is light
//                       ))),
//
//             Container(
//               child: RaisedButton.icon(
//                 onPressed: () {
//                   chooseImage(); // call choose image function
//                 },
//                 icon: Icon(Icons.folder_open),
//                 label: Text("CHOOSE IMAGE"),
//                 color: Colors.deepOrangeAccent,
//                 colorBrightness: Brightness.dark,
//               ),
//             ),
//             Container(
//               child: RaisedButton.icon(
//                 onPressed: () {
//                   uploadImage(); // call choose image function
//                 },
//                 icon: Icon(Icons.folder_open),
//                 label: Text("Upload"),
//                 color: Colors.deepOrangeAccent,
//                 colorBrightness: Brightness.dark,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }