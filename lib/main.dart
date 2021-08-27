import 'package:assignment_custom_randomiser/screens/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(AssignmentRandomiser());

class AssignmentRandomiser extends StatelessWidget {
  const AssignmentRandomiser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Assignment-Custom-Randomiser",
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Assignment-Randomiser",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Login(),
      ),
    );
  }
}
