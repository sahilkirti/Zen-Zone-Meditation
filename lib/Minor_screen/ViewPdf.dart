import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdf extends StatelessWidget {
  final url;
  const ViewPdf({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PdfViewerController? _pdfViewerController;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back , color: Colors.black,)),
        backgroundColor: Colors.white,
        title: Text(
          'PDF VIEW',
          style: GoogleFonts.abyssinicaSil(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SfPdfViewer.network(url , controller: _pdfViewerController,),
    );
  }
}
