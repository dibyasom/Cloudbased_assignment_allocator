import 'package:assignment_custom_randomiser/models/user.dart';
import 'package:assignment_custom_randomiser/widgets/csv_uploader.dart';
import 'package:assignment_custom_randomiser/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CreateContact extends StatefulWidget {
  const CreateContact({Key? key, required this.signedInUser}) : super(key: key);
  final SignedInUser signedInUser;

  @override
  _CreateContactState createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignedInUser>(
      create: (context) => widget.signedInUser,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contact config."),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1080) {
              return Row(
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: UserProfileCard(
                              signedInUser: widget.signedInUser),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Contact details form and action [Preview, Cancel].
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(35.0),
                            child: CsvUploader(),
                          ),
                        ),
                        //  Contact csv uploader.
                        Expanded(
                          child: Container(
                            child: Center(
                              child: SpinKitChasingDots(
                                color: Colors.deepPurple,
                                size: 100.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("Support rolling out soon <3 !"),
              );
            }
          },
        ),
      ),
    );
  }
}
