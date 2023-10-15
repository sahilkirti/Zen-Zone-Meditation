// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:final2/Screens/Upload_pdf.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:path/path.dart';
//
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   UploadTask? task;
//   File? file;
//
//   @override
//   Widget build(BuildContext context) {
//     final fileName = file != null ? basename(file!.path) : 'No File Selected';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Upload Pdf',
//           style: GoogleFonts.abyssinicaSil(color: Colors.black, fontSize: 24),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               ButtonWidget(
//                 text: 'Select Pdf',
//                 icon: Icons.attach_file,
//                 onClicked: selectFile,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 fileName,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 15),
//               ButtonWidget(
//                 text: 'Upload File',
//                 icon: Icons.cloud_upload_outlined,
//                 onClicked: uploadFile,
//               ),
//               SizedBox(height: 15),
//               task != null ? buildUploadStatus(task!) : Container(),
//               ButtonWidget(
//                 text: 'Fill Book Detail',
//                 icon: Icons.next_plan,
//                 onClicked: (){
//                   // Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadBook()));
//                 }
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//     if (result == null) return;
//     final path = result.files.single.path!;
//     setState(() => file = File(path));
//   }
//
//   Future uploadFile() async {
//     if (file == null) return;
//     final fileName = basename(file!.path);
//     final destination = 'Book-Pdf/$fileName';
//     task = FirebaseApi.uploadFile(destination, file!);
//     if (task == null) return;
//     final snapshot = await task!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//     print('Download-Link: $urlDownload');
//   }
//
//   Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
//         stream: task.snapshotEvents,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final snap = snapshot.data!;
//             final progress = snap.bytesTransferred / snap.totalBytes;
//             final percentage = (progress * 100).toStringAsFixed(2);
//
//             return Text(
//               '$percentage %',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             );
//           } else {
//             return Container();
//           }
//         },
//       );
// }
//
// class FirebaseApi {
//   static UploadTask? uploadFile(String destination, File file) {
//     try {
//       final ref = FirebaseStorage.instance.ref(destination);
//       return ref.putFile(file);
//     } on FirebaseException catch (e) {
//       return null;
//     }
//   }
//
//   static UploadTask? uploadBytes(String destination, Uint8List data) {
//     try {
//       final ref = FirebaseStorage.instance.ref(destination);
//
//       return ref.putData(data);
//     } on FirebaseException catch (e) {
//       return null;
//     }
//   }
// }
//

import 'package:final2/Screens/Upload/UploadPdf1.dart';
import 'package:final2/Screens/Upload/Upload_pdf.dart';
import 'package:final2/Screens/Upload/Upload_product.dart';
import 'package:final2/Screens/Upload/Upload_video.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(29, 194, 95, 1),
          minimumSize: Size.fromHeight(50),
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      );
}

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Upload Data',
          style: GoogleFonts.abyssinicaSil(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ButtonWidget(
              text: 'Upload Audio Details',
              icon: Icons.audio_file,
              onClicked: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadProductScreen()));
              },
            ),
            SizedBox(height: 20,),
            ButtonWidget(
              text: 'Upload E-Book Details',
              icon: Icons.book,
              onClicked: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadBook1()));
              },
            ),
            SizedBox(height: 20,),
            ButtonWidget(
              text: 'Upload Video detail',
              icon: Icons.video_library_outlined,
              onClicked: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadVideoScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
