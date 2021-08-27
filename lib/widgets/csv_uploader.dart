import 'package:assignment_custom_randomiser/widgets/firebase_storage_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CsvUploader extends StatefulWidget {
  const CsvUploader({Key? key}) : super(key: key);

  @override
  _CsvUploaderState createState() => _CsvUploaderState();
}

class _CsvUploaderState extends State<CsvUploader> {

  bool _uploadComplete = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1D0045),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Kindly pick a '.csv' file with student contact details.",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Divider(
                thickness: 2.0,
                height: 10.0,
                color: Colors.blueAccent,
                indent: 50.0,
                endIndent: 50.0,
              ),
              FirebaseUploaderWithProgressIndicator(),
              Divider(
                thickness: 2.0,
                height: 10.0,
                color: Colors.blueAccent,
                indent: 50.0,
                endIndent: 50.0,
              ),
              ButtonBar(
                children: [
                  OutlinedButton(
                    onPressed: () => (_uploadComplete) ? print("Uploaded!") : null,
                    child: Icon(
                      Icons.check_circle,
                      size: 30.0,
                      color: Colors.green,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.cancel,
                      size: 30.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
