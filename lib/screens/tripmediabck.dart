// import 'dart:ffi';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:ffi/ffi.dart';
// import 'package:image/image.dart' as imglib;
// import 'package:path/path.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:image_picker/image_picker.dart';

// typedef convert_func = Pointer<Uint32> Function(
//     Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Int32, Int32, Int32, Int32);
// typedef Convert = Pointer<Uint32> Function(
//     Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int, int, int, int);

// class MediaTabTripSheet extends StatefulWidget {
//   const MediaTabTripSheet({key}) : super(key: key);

//   @override
//   _MediaTabTripSheetState createState() => _MediaTabTripSheetState();
// }

// class _MediaTabTripSheetState extends State<MediaTabTripSheet> {
//   double width, height;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2

//   CameraDescription camera;
//   CameraController controller;
//   bool _isInited = false;
//   String _url;
//   File imageFile = null;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final cameras = await availableCameras();
//       //print(cameras);
//       // setState(() {});
//       // Get a specific camera from the list of available cameras.
//       final firstCamera = cameras.first;
//       controller = CameraController(firstCamera, ResolutionPreset.medium);
//       controller.initialize().then((value) => {
//             setState(() {
//               _isInited = true;
//             })
//           });
//     });
//   }

//   //********************** IMAGE PICKER
//   Future imageSelector(BuildContext context, String pickerType) async {
//     switch (pickerType) {
//       case "gallery":

//         /// GALLERY IMAGE PICKER
//         imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
//         break;

//       case "camera": // CAMERA CAPTURE CODE
//         imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
//         break;
//     }

//     if (imageFile != null) {
//       print("You selected  image : " + imageFile.path);
//       setState(() {
//         debugPrint("SELECTED IMAGE PICK   $imageFile");
//       });
//     } else {
//       print("You have not taken image");
//     }
//   }

//   // Image picker
//   void _settingModalBottomSheet(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return Container(
//             child: new Wrap(
//               children: <Widget>[
//                 new ListTile(
//                     title: new Text('Gallery'),
//                     onTap: () => {
//                           imageSelector(context, "gallery"),
//                           Navigator.pop(context),
//                         }),
//                 new ListTile(
//                   title: new Text('Camera'),
//                   onTap: () => {
//                     imageSelector(context, "camera"),
//                     Navigator.pop(context)
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     width = MediaQuery.of(context).size.width;
//     height = MediaQuery.of(context).size.height;
//     final textStyle =
//         TextStyle(color: Colors.black, fontSize: height * 2.5 / 100);
//     final textStyle2 = TextStyle(
//         color: Colors.black,
//         fontWeight: FontWeight.bold,
//         fontSize: height * 2.2 / 100);
//     return SingleChildScrollView(
//       child:
//           //      Column(
//           //   children: [
//           //     buildColumn(textStyle, textStyle2, 'Load Photo'),
//           //     Divider(height: height * .2 / 100, color: Colors.black),
//           //     Padding(
//           //       padding: const EdgeInsets.all(8.0),
//           //       child: buildColumn(textStyle, textStyle2, 'Unloading Photo'),
//           //     ),
//           //     Divider(height: height * .2 / 100, color: Colors.black),
//           //     Padding(
//           //       padding: const EdgeInsets.all(8.0),
//           //       child: buildColumn(textStyle, textStyle2, 'Unload Photo'),
//           //     ),
//           //   ],
//           // ),
//           Column(
//         children: <Widget>[
//           Container(
//               width: MediaQuery.of(context).size.width * 0.35,
//               height: MediaQuery.of(context).size.height * 0.2,
//               margin: EdgeInsets.only(top: 20),
//               decoration: BoxDecoration(
//                   color: Colors.grey,
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                       image: imageFile == null
//                           ? AssetImage('images/ic_business.png')
//                           : FileImage(File(imageFile.path)),
//                       fit: BoxFit.cover))),
//           SizedBox(
//             height: 10.0,
//           ),
//           RaisedButton(
//               onPressed: () {
//                 _settingModalBottomSheet(context);
//               },
//               child: Text("Take Photo")),
//         ],
//       ),
//     );
//   }

//   Column buildColumn(TextStyle textStyle, TextStyle textStyle2, String title) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: textStyle,
//             ),
//             Row(
//               children: [
//                 Text(
//                   'Time : ',
//                   style: textStyle,
//                 ),
//                 Text(
//                   '21-04-2021',
//                   style: textStyle2,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: _isInited
//                   ? AspectRatio(
//                       aspectRatio: controller.value.aspectRatio,
//                       child: CameraPreview(controller),
//                     )
//                   : Container(),
//             ),
//             Container(
//               height: 152,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: 120,
//                     width: 120,
//                     child: _url != null
//                         ? Image.file(
//                             File(_url),
//                             height: 120,
//                             width: 120,
//                           )
//                         : Container(),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(width * 2 / 100),
//               child: IconButton(
//                 icon: Icon(Icons.camera_alt_sharp),
//                 onPressed: () async {
//                   final path = join((await getTemporaryDirectory()).path,
//                       '${DateTime.now()}.jpg');
//                   await controller.takePicture().then((res) => {
//                         setState(() {
//                           _url = path;
//                         })
//                       });
//                 },
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(width * 2 / 100),
//               child: const Icon(Icons.add_photo_alternate_outlined),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
