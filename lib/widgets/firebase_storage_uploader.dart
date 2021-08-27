import 'dart:typed_data';

import 'package:assignment_custom_randomiser/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class FirebaseUploaderWithProgressIndicator extends StatefulWidget {
  const FirebaseUploaderWithProgressIndicator({Key? key}) : super(key: key);

  @override
  _FirebaseUploaderWithProgressIndicatorState createState() =>
      _FirebaseUploaderWithProgressIndicatorState();
}

class _FirebaseUploaderWithProgressIndicatorState
    extends State<FirebaseUploaderWithProgressIndicator> {
  bool _uploadStarted = false;
  double _transferProgress = 0;
  String taskState = "Uploading";

  Future<void> handleTaskExample2(String uid) async {
    FilePickerResult? largeFile = await FilePicker.platform
        // TODO: csv, excel,
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv', 'xlxs']);

    if (largeFile != null) {
      setState(() {
        _uploadStarted = true;
      });

      Uint8List? fileBytes = largeFile.files.first.bytes;
      String fileName = largeFile.files.first.name;
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref('$uid/$fileName')
          .putData(fileBytes!);

      task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
        print('Task state: ${snapshot.state}');
        setState(() {
          taskState = snapshot.state.toString();
        });
        print(
            'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');

        // Update transfer progress for easy tracking.
        setState(() {
          _transferProgress = (snapshot.bytesTransferred / snapshot.totalBytes);
        });
      }, onError: (e) {
        // The final snapshot is also available on the task via `.snapshot`,
        // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
        print(task.snapshot);

        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
        }
      });

      // We can still optionally use the Future alongside the stream.
      try {
        await task;
        setState(() {
          taskState = "Upload complete <3";
        });

        print('Upload complete.');
      } on firebase_core.FirebaseException catch (e) {
        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
        }
        // ...
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<SignedInUser>(context).user!.uid;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Center(
        child: ElevatedButton(
          onPressed: () async => await handleTaskExample2(uid),
          child: (this._uploadStarted)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      this.taskState,
                      style: GoogleFonts.roboto(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: LinearPercentIndicator(
                            width: constraints.maxWidth * 0.45,
                            lineHeight: 25.0,
                            percent: this._transferProgress,
                            center: Text(
                              "${(this._transferProgress * 100).toStringAsFixed(2)}%",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.greenAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Text(
                  "Pick file.",
                  style: GoogleFonts.roboto(fontSize: 30.0),
                ),
        ),
      );
    });
  }
}
